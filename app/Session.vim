let SessionLoad = 1
if &cp | set nocp | endif
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/projects/git/readingp-fe
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +8 ~/Downloads/gradient-line.svg
badd +1 ~/.Xdefaults
badd +1 ~/projects/git/readingparty/s-project.json
badd +1 ~/projects/git/readingparty/api/books/createBook/s-function.json
badd +1 ~/projects/git/readingparty/api/books/getBook/s-function.json
badd +1 ~/projects/work/frontend/startingpoints-site-features/features/core/layouts/index.html
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/test/sandbox/layouts/index.html
badd +1 ~/projects/work/frontend/startingpoints-site-features/features/core/config/core.features.module.js
badd +1 ~/projects/work/frontend/startingpoints-site-features/features/core/config/core.features.run.js
badd +1 ~/projects/work/frontend/startingpoints-site-features/Dockerfile
badd +1 ~/projects/work/frontend/startingpoints-site-features/features/core/config/core.features.config.js
badd +1 ~/projects/work/frontend/startingpoints-site-features/features/landing/login/controllers/login.landing.controller.js
badd +1 ~/projects/work/frontend/startingpoints-site-features/features/contacts/config/contacts.states.js
badd +1 ~/projects/work/frontend/startingpoints-site-features/gulp/scripts.js
badd +1 ~/projects/work/frontend/startingpoints-site-features/features/landing/login/views/login.html
badd +1 ~/projects/work/frontend/startingpoints-site-features/features/dashboard/views/dashboard.html
badd +1 ~/projects/work/frontend/startingpoints-site-features/gulp/vendor-scripts.js
badd +1 ~/projects/work/frontend/startingpoints-site-features/features/inbox/views/contacts.view.html
badd +1 ~/projects/work/frontend/startingpoints-site-features/features/inbox/config/inbox.states.js
badd +1 ~/projects/work/frontend/startingpoints-site-features/features/inbox/controllers/inbox.controller.js
badd +1 ~/projects/work/frontend/startingpoints-site-features/features/inbox/views/inbox.view.html
badd +1 ~/projects/work/frontend/startingpoints-site-features/features/core/scss/app.scss
badd +1 ~/projects/work/frontend/startingpoints-site-features/gulp/vendor-styles.js
badd +1 ~/projects/work/frontend/startingpoints-site-features/gulpfile.js
badd +1 ~/projects/work/frontend/startingpoints-site-features/.netrwhist
badd +1 ~/hdd/hbu/projects/Work/startingpoints-api-docker/Dockerfile
badd +1 ~/hdd/hbu/projects/Work/startingpoints-api-docker/fe/.startup
badd +1 ~/hdd/hbu/projects/Work/startingpoints-api-docker/fe/Dockerfile
badd +1 ~/hdd/hbu/projects/Work/startingpoints-api-docker/fe/nginx.conf
badd +1 ~/hdd/hbu/projects/Work/startingpoints-api-docker/frontend/.startup
badd +1 ~/hdd/hbu/projects/Work/startingpoints-api-docker/frontend/Dockerfile
badd +1 ~/hdd/hbu/projects/Work/startingpoints-api-docker/envsetup.sh
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/modals/createGroup/create-group-modal.html
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/modals/messageModal/createMessageModal.html
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/modals/modalbase/modal.template.html
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/modals/scss/modal.components.scss
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/layout/addNew/templates/floatingmenu.html
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/modals/modalbase/modal.prototype.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/modals/messageModal/createMessage.modal.component.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/lists/listItems/groupListItem/list-item-group.html
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/modals/inviteModal/invite-modal.html
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/modals/inviteModal/inviteModal.modal.function.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/lists/listItems/groupListItem/group-list-item.lists.function.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/lists/spec/group-list.spec.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/test/helpers/directiveTest.helper.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/test/helpers/loadModules.helper.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/karma.conf.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/layout/sidebar/templates/sidebar.html
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/lists/collapseList/collapse-list-message.html
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/lists/listItems/messageListItem/list-item-message.html
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/thread/thread.widgets.component.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/thread/thread.html
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/contacts/contacts.widgets.component.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/components.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/contacts/contacts.html
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/groupdash-members/members.groupdash.widgets.component.html
badd +1 ~/projects/work/frontend/startingpoints-lib-services/services/api/messageService.js
badd +1 ~/projects/work/frontend/startingpoints-lib-services/services/components/addNewDialogService.js
badd +1 ~/projects/work/frontend/startingpoints-lib-services/services/startingPointServicesModule.js
badd +1 ~/projects/work/frontend/startingpoints-lib-services/services/api/groupService.js
badd +1 ~/projects/work/frontend/startingpoints-site-features/features/dashboard/controllers/dashboard.controller.js
badd +1 ~/projects/work/frontend/startingpoints-site-features/features/group/config/group.states.js
badd +1 ~/projects/work/frontend/startingpoints-site-features/features/inbox/views/thread.view.html
badd +1 ~/projects/work/frontend/startingpoints-site-features/features/inbox/controllers/thread.controller.js
badd +1 ~/projects/work/frontend/startingpoints-site-features/features/group/views/group.view.html
badd +1 ~/projects/work/frontend/startingpoints-site-features/Makefile
badd +1 app/app.component.ts
badd +21 app/auth/login/auth.service.ts
badd +35 app/book/dashboard/book.service.ts
badd +37 app/book/dashboard/bookDash.component.ts
badd +1 app/book/dashboard/book.ts
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/layout/header/directives/dropdown-menu.layout.component.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/test/sandbox/js/sandbox.patterns.module.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/utils/directives/fileAttachment.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/utils/templates/fileAttachment.html
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/utils/directives/pageOverlay.util.component.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/utils/components.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/groupdash-messages/messages.groupdash.widgets.component.html
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/lists/scss/lists.components.scss
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/layout/scss/layout.components.scss
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/lists/collapseList/collapse-list-group.html
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/lists/listItems/memberListItem/list-item-member.html
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/groupdash-messages/messages.groupdash.widgets.component.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/utils/templates/page-overlay-template.html
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/utils/directives/fileAttachment.util.component.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/scss/widgets.component.scss
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/app.scss
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/chat/chat.widgets.component.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/test/sandbox/views/sandbox.html
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/chat/chat.html
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/test/sandbox/js/sandbox.patterns.controllers.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/test/sandbox/js/sandbox.patterns.run.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/groups/groups.widgets.components.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/groups/groups.widgets.components.html
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/groupdash-members/members.groupdash.widgets.component.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/feed/feed.widgets.component.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/feed/feed.widgets.component.html
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/test/sandbox/js/sandbox.patterns.config.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/groups/groups.widgets.component.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/groups/groups.widgets.component.html
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/forms/templates/labelled-field.html
badd +1 ~/projects/work/frontend/startingpoints-lib-services/services/api/groupsService.js
badd +1 ~/projects/work/frontend/startingpoints-lib-services/services/components/scrollWatcherService.js
badd +1 ~/projects/work/frontend/startingpoints-lib-services/services/components/breadcrumbService.js
badd +1 ~/projects/work/frontend/startingpoints-lib-services/services/components/categoryService.js
badd +241 ~/projects/work/frontend/startingpoints-lib-services/services/api/memberService.js
badd +1 features/widgets/contacts/contacts.widgets.component.js
badd +1 features/widgets/contacts/contacts.html
badd +1 features/widgets/groupdash-members/members.groupdash.widgets.component.html
badd +1 features/widgets/groupdash-messages/messages.groupdash.widgets.component.html
badd +1 features/widgets/groupdash-messages/messages.groupdash.widgets.component.js
badd +1 features/widgets/chat/chat.widgets.component.js
badd +1 features/widgets/chat/chat.html
badd +1 features/widgets/groups/groups.widgets.components.js
badd +1 features/widgets/groups/groups.widgets.components.html
badd +1 features/widgets/groupdash-members/members.groupdash.widgets.component.js
badd +1 features/widgets/groups/groups.widgets.component.js
badd +1 features/widgets/groups/groups.widgets.component.html
badd +1 features/widgets/contacts/contactPage.html
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/lists/inboxList/inbox-list.html
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/members/contacts.html
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/members/memberSnippet/contacts.html
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/members/memberSnippet/contacts.widgets.component.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/members/memberSnippet/memberSnippet.html
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/members/contacts/contacts.html
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/members/contacts/\ contacts.widgets.component.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/members/memberSnippet/memberSnippet.widgets.component.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/members/contacts/contacts.widgets.component.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/dashboard-groups/groups.widgets.component.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/dashboard-chat/chat.html
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/dashboard-chat/chat.widgets.component.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/lists/listItems/memberListItem/member-list-item.lists.function.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/lists/listItems/categoryListItem/category-list-item.lists.component.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/lists/listItems/categoryListItem/list-item-category.html
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/members/memberList/memberList.html
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/members/memberList/memberList.members.widgets.component.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/forms/directives/input.radio.component.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/forms/spec/input.checkbox.component.spec.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/lists/components.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/members/profile/profile.members.widgets.component.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/members/profile/profile.html
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/members/components.js
badd +1 ~/projects/work/frontend/startingpoints-site-features/features/dashboard/config/dashboard.states.js
badd +1 ~/projects/work/frontend/startingpoints-site-features/features/contacts/views/contacts.view.html
badd +1 ~/projects/work/frontend/startingpoints-site-features/features/group/controllers/group.controller.js
badd +1 ~/projects/work/frontend/startingpoints-site-features/features/members/config/members.states.js
badd +1 ~/projects/work/frontend/startingpoints-site-features/features/members/views/members.view.html
badd +1 ~/projects/work/frontend/startingpoints-site-features/features/members/controllers/members.controller.js
badd +1 ~/projects/work/frontend/startingpoints-site-features/features/members/controllers/profile.members.controller.js
badd +1 ~/projects/work/frontend/startingpoints-site-features/features/core/controllers/header.core.controller.js
badd +1 ~/projects/work/frontend/startingpoints-site-features/features/core/controllers/sidebar.core.controller.js
badd +1 ~/projects/work/frontend/startingpoints-site-features/features/core/controllers/floatingMenu.core.controller.js
badd +1 ~/projects/work/frontend/startingpoints-lib-services/services/utils/filePickerService.js
badd +1 ~/projects/work/frontend/startingpoints-lib-services/services/api/feedService.js
badd +1 ~/projects/work/frontend/startingpoints-site-features/.git/MERGE_MSG
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/lists/collapseList/collapse-list.list.component.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/utils/directives/form.util.component.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/utils/directives/infiniteScroll.util.component.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/layout/header/directives/header.layout.component.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/layout/sidebar/directives/groupList.sidebar.layout.component.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/layout/sidebar/directives/sidebar.layout.component.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/layout/breadcrumb/directives/breadcrumb.layout.component.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/layout/breadcrumb/templates/breadcrumb.html
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/layout/components.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/lists/inboxList/inboxList.list.component.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/test/sandbox/views/login.html
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/vendors/material-admin/views/profile.html
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/scss/_mixins.scss
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/scss/_variables.scss
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/patterns.startingpoints.module.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/layout/sidebar/templates/sidebar-group-list.html
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/dashboard-groups/groups.widgets.component.html
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/layout/header/templates/header.html
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/layout/header/directives/dropdown-list-item.layout.component.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/layout/body/stateload.layout.component.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/vendors/material-admin/js/config.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/gulpfile.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/modals/createGroup/createGroup.modal.function.js
badd +1 ~/projects/work/frontend/startingpoints-lib-services/services/libServices.js
badd +1 ~/projects/work/frontend/startingpoints-lib-services/libServices.js
badd +1 ~/projects/work/frontend/startingpoints-lib-services/gulpfile.js
badd +1 ~/projects/work/frontend/startingpoints-lib-services/Makefile
badd +1 ~/projects/work/frontend/startingpoints-lib-services/Dockerfile
badd +1 ~/projects/work/frontend/startingpoints-lib-services/karma.conf.js
badd +1 ~/projects/work/frontend/startingpoints-lib-services/services/utils/pricingService.js
badd +1 ~/projects/work/frontend/startingpoints-lib-services/services/api/memberSearchService.js
badd +1 ~/projects/work/frontend/startingpoints-lib-services/services/api/userService.js
badd +1 ~/projects/work/frontend/startingpoints-lib-services/.git/index
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/vendors/material-admin/img/headers/1.png
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/modals/inviteModal/emailValidation.inviteModal.helper.function.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/addnew
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/vendors/materialApp/materialApp.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/utils/scss/utils.component.scss
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/modals/messageModal/typeahead.createMessage.modal.component.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/modals/messageModal/createMessageTypeAhead.html
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/modals/components.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/forms/templates/input-dropdown.html
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/forms/directives/form-error.form.component.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/forms/directives/input.dropdown.component.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/layout/addNew/directives/floatingmenu.layout.component.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/modals/directives/confirmation.modal.component.js
badd +2 ~/projects/work/frontend/startingpoints-lib-patterns/features/modals/members/remove.member.modal.html
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/modals/resetPasswordModal/reset-password-modal.html
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/modals/resetPasswordModal/resetPassword.modal.function.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/modals/members/leader.member.modal.html
badd +8 app/book/dashboard/bookDash.component.html
badd +5 app/auth/login/login.component.html
badd +3 app/book/dashboard/bookDash.component.css
badd +27 app/auth/login/login.component.ts
argglobal
silent! argdel *
edit app/auth/login/auth.service.ts
set splitbelow splitright
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
argglobal
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=1
setlocal fml=10
setlocal fdn=2
setlocal fen
7
normal! zo
14
normal! zo
let s:l = 22 - ((21 * winheight(0) + 23) / 47)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
22
normal! 07|
lcd ~/projects/git/readingp-fe
tabnext 1
if exists('s:wipebuf')
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToOc
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
let g:this_session = v:this_session
let g:this_obsession = v:this_session
let g:this_obsession_status = 2
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
