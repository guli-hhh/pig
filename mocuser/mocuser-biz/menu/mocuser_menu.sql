-- 该脚本不要直接执行， 注意维护菜单的父节点ID 默认 父节点-1 

-- 菜单SQL
insert into sys_menu ( menu_id,parent_id, path, permission, menu_type, icon, del_flag, create_time, sort_order, update_time, name)
values (1711017280638, '-1', '/mocuser/mocuser/index', '', '0', 'icon-bangzhushouji', '0', null , '8', null , 'moc用户系统管理');

-- 菜单对应按钮SQL
insert into sys_menu ( menu_id,parent_id, permission, menu_type, path, icon, del_flag, create_time, sort_order, update_time, name)
values (1711017280639,1711017280638, 'mocuser_mocuser_view', '1', null, '1',  '0', null, '0', null, 'moc用户系统查看');

insert into sys_menu ( menu_id,parent_id, permission, menu_type, path, icon, del_flag, create_time, sort_order, update_time, name)
values (1711017280640,1711017280638, 'mocuser_mocuser_add', '1', null, '1',  '0', null, '1', null, 'moc用户系统新增');

insert into sys_menu (menu_id, parent_id, permission, menu_type, path, icon,  del_flag, create_time, sort_order, update_time, name)
values (1711017280641,1711017280638, 'mocuser_mocuser_edit', '1', null, '1',  '0', null, '2', null, 'moc用户系统修改');

insert into sys_menu (menu_id, parent_id, permission, menu_type, path, icon, del_flag, create_time, sort_order, update_time, name)
values (1711017280642,1711017280638, 'mocuser_mocuser_del', '1', null, '1',  '0', null, '3', null, 'moc用户系统删除');

insert into sys_menu ( menu_id,parent_id, permission, menu_type, path, icon, del_flag, create_time, sort_order, update_time, name)
values (1711017280643,1711017280638, 'mocuser_mocuser_export', '1', null, '1',  '0', null, '3', null, '导入导出');