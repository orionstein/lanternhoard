let SessionLoad = 1
if &cp | set nocp | endif
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/projects/git/lanternhoard/app
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +1 ~/
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/elm
badd +2 ~/projects/work/frontend/startingpoints-site-features/features/core/layouts/index.html
badd +38 ~/projects/work/frontend/startingpoints-lib-patterns/elm/feed/src/Comment.elm
badd +1 ~/projects/work/frontend/startingpoints-lib-services
badd +1 ~/projects/git/lanternhoard/api-old/kdstore-of
badd +1 ~/projects/git/lanternhoard/api/kdStoreCrawl
badd +122 ~/projects/work/frontend/startingpoints-site-features/features/calendar/config/calendar.states.js
badd +1 ~/projects/git/lanternhoard/app
badd +16 gulpfile.js
badd +1 app/home/home.component.html
badd +6 app/app.component.html
badd +34 index.html
badd +11 app/storewatch/store.service.ts
badd +119 app/storewatch/storeWatch.component.ts
badd +3 app/storewatch/storeWatch.component.html
badd +23 app/storewatch/storeWatch.component.css
badd +1 app/storewatch/storeItem.ts
badd +2 app/storewatch/storeEntry.ts
badd +32 ~/projects/work/frontend/startingpoints-site-features/features/group/config/group.states.js
badd +33 ~/projects/work/frontend/startingpoints-site-features/features/core/config/core.features.run.js
badd +1 ~/projects/work/frontend/startingpoints-site-features/features/core/config
badd +77 ~/projects/work/frontend/startingpoints-site-features/features/core/config/core.features.config.js
badd +3 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/feed/feed.widgets.component.back.html
badd +4 ~/projects/work/frontend/startingpoints-lib-patterns/features/lists/accountGroupsList/account-groups-listItem.component.html
badd +43 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/calendar/createEvent/createEvent.widget.html
badd +110 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/calendar/createEvent/createEvent.widget.component.js
badd +330 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/calendar/createEvent/editEvent.widget.component.js
badd +19 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/calendar/createEvent/editEvent.widget.html
badd +198 ~/projects/work/frontend/startingpoints-lib-patterns/elm/feed/src/Thread.elm
badd +333 ~/projects/work/frontend/startingpoints-lib-patterns/elm/feed/src/Event.elm
badd +1167 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/scss/widgets.component.scss
badd +58 ~/projects/work/frontend/startingpoints-lib-patterns/features/scss/_mixins.scss
badd +41 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/feed/search.feed.widgets.component.html
badd +23 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/feed/search.feed.widgets.component.js
badd +31 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/thread/thread.html
badd +143 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/thread/thread.widgets.component.js
badd +117 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/event/event.html
badd +73 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/event/event.widgets.component.js
badd +10 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/account/myGroups/my-groups.widgets.component.html
badd +16 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/account/settings/settings.widget.component.html
badd +33 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/account/profile/profile.widgets.template.html
badd +58 ~/projects/work/frontend/startingpoints-lib-patterns/features/modals/upgradeGroupPlanModal/upgradePlanModal.html
badd +167 ~/projects/work/frontend/startingpoints-lib-patterns/features/modals/upgradeGroupPlanModal/upgradePlanModal.function.js
badd +118 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/calendar/calendar.widget.component.js
badd +12 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/calendar/address/address.calendar.widget.component.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/calendar/address/address.calendar.widget.html
badd +4 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/email-preview/modal-alerts/confirmResend.action.function.js
badd +51 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/email-preview/email-preview.html
badd +28 ~/projects/git/lanternhoard/api-old/kdstore-of/api/kdStorePageItems/handler.js
badd +9 ~/projects/git/lanternhoard/api-old/kdstore-of/api/kdStorePageItems/s-function.json
badd +24 ~/projects/git/lanternhoard/api-old/kdstore-of/api/kdTextInbound/s-function.json
badd +27 ~/projects/git/lanternhoard/api-old/kdstore-of/api/kdStoreSubscribe/s-function.json
badd +4 ~/projects/work/frontend/startingpoints-lib-services/services/api/event/eventCommentService.js
badd +15 ~/projects/work/frontend/startingpoints-lib-services/services/api/event/eventResponseService.js
badd +2 ~/projects/work/frontend/startingpoints-lib-services/services/api/event/eventService.js
badd +47 ~/projects/work/frontend/startingpoints-lib-services/services/api/event/eventModel.js
badd +55 ~/projects/work/frontend/startingpoints-lib-services/services/utils/pricingService.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/elm/feed/src/Datehelper.elm
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/forms/directives/form-error.form.component.js
badd +2 ~/projects/work/frontend/startingpoints-lib-patterns/features/forms/directives/form-field-alt.form.component.js
badd +15 ~/projects/work/frontend/startingpoints-lib-patterns/features/forms/directives/labelled-field.form.component.js
badd +3 ~/projects/work/frontend/startingpoints-lib-patterns/features/forms/templates/form-field-alt.html
badd +10 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/members/profile/profile.html
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/members/profile
badd +25 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/members/profile/profile.members.widgets.component.js
badd +43 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/account/profile/profile.widgets.component.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/layout/header/directives/header.layout.component.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/layout/header/directives
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/layout/header/templates/header.html
badd +58 ~/projects/work/frontend/startingpoints-lib-patterns/features/layout/header/templates/mobile.header.html
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/layout/header/templates/landing-header.html
badd +98 ~/projects/work/frontend/startingpoints-site-features/features/core/scss/app.scss
badd +45 ~/projects/work/frontend/startingpoints-site-features/features/dashboard/config/dashboard.states.js
badd +14 ~/projects/work/frontend/startingpoints-site-features/features/contacts/config/contacts.states.js
badd +22 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/account/editPassword/edit-password.widgets.component.html
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/scss
badd +9 ~/projects/work/frontend/startingpoints-lib-patterns/features/scss/_globals.scss
badd +35 ~/projects/work/frontend/startingpoints-lib-patterns/features/utils/directives/emptyState.util.component.js
badd +64 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/email-preview/email-preview.widgets.component.js
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/dashboard-groups/groups.widgets.component.html
badd +13 ~/projects/work/frontend/startingpoints-lib-patterns/elm/feed/src/ScriptScope.elm
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/\"elm/\\\\\"
badd +1 ~/projects/work/frontend/startingpoints-lib-patterns/.git
badd +24 ~/projects/work/frontend/startingpoints-lib-patterns/features/modals/messageModal/typeahead.createMessage.modal.component.js
badd +13 ~/projects/work/frontend/startingpoints-lib-patterns/features/modals/messageModal/createMessageModal.html
badd +3 ~/projects/work/frontend/startingpoints-lib-patterns/features/modals/messageModal/createMessageTypeAhead.html
badd +5 ~/projects/work/frontend/startingpoints-lib-patterns/features/widgets/calendar/createEvent/eventFormHelpers.js
badd +63 ~/projects/work/frontend/startingpoints-lib-services/package.json
badd +15 elm/storewatch/src/Main.elm
badd +17 elm/storewatch/src/StoreEntry.elm
badd +48 elm/storewatch/src/StoreEntryDiff.elm
badd +66 scss/app.scss
badd +9 Makefile
badd +1 dist-make
badd +30 elm/storewatch/src/StoreItemDiff.elm
argglobal
silent! argdel *
edit app/storewatch/storeWatch.component.ts
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
12
normal! zo
24
normal! zo
115
normal! zo
let s:l = 119 - ((13 * winheight(0) + 13) / 27)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
119
normal! 033|
lcd ~/projects/git/lanternhoard/app
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
