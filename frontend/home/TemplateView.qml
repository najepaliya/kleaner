import "TemplateViewFunctions.js" as F

AbstractView {
    viewTitle: "Templates"
    viewModel: 4

    headerButtonList: [
        {
            icon: "list-add",
            function: F.addTemplate
        }
    ]
    
    rowButtonList: [
        {
            icon: "edit-entry",
            function: F.editTemplate
        },
        {
            icon: "edit-delete",
            function: F.deleteTemplate
        }
    ]
}