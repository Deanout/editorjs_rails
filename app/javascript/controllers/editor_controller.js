import { Controller } from "@hotwired/stimulus";
import EditorJS from "@editorjs/editorjs";

// These are the plugins
import CodeTool from "@editorjs/code";
import Header from "@editorjs/header";
import List from "@editorjs/list";
import Paragraph from "@editorjs/paragraph";

// Connects to data-controller="editor"
export default class extends Controller {
  static targets = ["article_content"];

  connect() {
    console.log("Hello, Stimulus!", this.element);

    const initialContent = this.getInitialContent();

    this.contentEditor = new EditorJS({
      // Holder is the target element
      holder: this.article_contentTarget,
      data: initialContent,
      tools: {
        header: {
          class: Header,
        },
        list: {
          class: List,
        },
        paragraph: {
          class: Paragraph,
          config: {
            inlineToolbar: true,
          },
        },
        code: CodeTool,
      },
    });

    this.element.addEventListener("submit", this.saveEditorData.bind(this));
  }

  getInitialContent() {
    const hiddenContentField = document.getElementById(
      "article_content_hidden"
    );
    if (hiddenContentField && hiddenContentField.value) {
      return JSON.parse(hiddenContentField.value);
    }
    return {};
  }

  async saveEditorData(event) {
    event.preventDefault();

    const outputData = await this.contentEditor.save();
    const articleForm = this.element;

    const hiddenInput = document.getElementById("article_content_hidden");

    hiddenInput.value = JSON.stringify(outputData);
    articleForm.submit();
  }
}
