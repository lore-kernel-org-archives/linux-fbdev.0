From: Inki Dae <inki.dae@samsung.com>
Date: Tue, 04 Oct 2011 10:29:11 +0000
Subject: [RESENT][PATCH v2 0/2] fb: add early fb blank feature
Message-Id: <003f01cc8280$7510c5c0$5f325140$%dae@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

this patch adds early fb blank feature that a callback of lcd panel driver
is called prior to specific fb driver's one. in case of MIPI-DSI based video
mode LCD Panel, for lcd power off, the power off commands should be
transferred to lcd panel with display and mipi-dsi controller enabled
because the commands is set to lcd panel at vsync porch period. and in
opposite case, the callback of fb driver should be called prior to lcd panel
driver's one because of same issue. and also if fb_blank mode is changed to
FB_BLANK_POWERDOWN then display controller would be off(clock disable) but
lcd panel would be still on. at this time, you could see some issue like
sparkling on lcd panel because video clock to be delivered to ldi module of
lcd panel was disabled. this issue could occurs for all lcd panels.

the callback order is as the following:

at fb_blank function of fbmem.c
-> fb_notifier_call_chain(FB_EARLY_EVENT_BLANK)
       -> lcd panel driver's early_set_power()
-> info->fbops->fb_blank()
       -> spcefic fb driver's fb_blank()
-> fb_notifier_call_chain(FB_EVENT_BLANK)
       -> lcd panel driver's set_power()
   -> fb_notifier_call_chain(FB_R_EARLY_EVENT_BLANK) if
info->fops->fb_blank() was failed.

fb_notifier_call_chain(FB_R_EARLY_EVENT_BLANK) would be called to revert the
effects of previous FB_EARLY_EVENT_BLANK call. and note that if
early_set_power() of lcd_ops is NULL then early fb blank callback would be
ignored.

this patch is based on git repository below:
git://github.com/schandinat/linux-2.6.git
branch: fbdev-next
commit-id: 2b7a905dd0d24d14a1099653ba63b7113a82fc54

Links to previous versions of the patchset:
v1: < http://lkml.indiana.edu/hypermail/linux/kernel/1109.1/00413.html >

Changelog v2:
fb: add fb early blank event instead of early_blank_mode variable.
       fb notifier can know whether early blank mode is support or not
checking if early_set_power callback is NULL or not.

fb: add exception codes at fb_blank().
       the effects of previous FB_EARLY_EVENT_BLANK call should be reverted
if info->fbops->fb_blank() was failed.

fb: add code clean.

Changelog RESEND:
fb: fixed condition.
     this patch changes 'if (early_ret < 0)' to 'if (!early_ret)' of
fb_blank function.

these patch series are as the following:
[RESEND][PATCH v2 0/2] fb: add early fb blank feature.
       introduce new early fb blank feature.
[RESEND][PATCH v2 1/2] lcd: add callbacks for early fb event blank support.
[RESEND][PATCH v2 2/2] fb: add events for early fb event support.

Signed-off-by: Inki Dae <inki.dae@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

