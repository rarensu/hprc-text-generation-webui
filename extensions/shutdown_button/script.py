import gradio as gr
from modules import shared, ui, utils
import os

js = """
function close_window() {
  if (confirm("Close the application?")) {

    document.body.innerHTML = ''
    var messageDiv = document.createElement('div');
    messageDiv.textContent = 'You may close this window. This window may close automatically after a few seconds.';
    messageDiv.style.display = 'flex';
    messageDiv.style.alignItems = 'center';
    messageDiv.style.justifyContent = 'center';
    messageDiv.style.textAlign = 'center';

    messageDiv.style.fontWeight = 'bold';
    messageDiv.style.fontSize = '40px'; // 

    // Set the background color
    document.body.style.backgroundColor = '#d49013'; 

    // Append the message div to the body
    document.body.appendChild(messageDiv);

     setTimeout(function() {
      window.close();
    }, 2000);

    return true;

  } else {
    return false;
  }
}
"""

def ui():
    mu = shared.args.multi_user
    with shared.gradio['session-top-row']:
        shutdown_btn = gr.Button("Exit ⭕",
            elem_id="stop_button", size="sm", variant='stop', interactive=not mu)
        hidden_checkbox = gr.Checkbox(visible=False)

        def when(hidden_state):
            if hidden_state:
                os._exit(0)
            return False
    shutdown_btn.click(when, hidden_checkbox, hidden_checkbox, _js=js)
