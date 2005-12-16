From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Re: i810fb_blank
Date: Fri, 16 Dec 2005 14:00:00 +0800
Message-ID: <43A257E0.9030204@gmail.com>
References: <200512151614.44766.lucasvr@gobolinux.org> <43A1F906.4060608@gmail.com> <200512160155.17019.lucasvr@gobolinux.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1En8dq-0004tp-HM
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 15 Dec 2005 22:00:30 -0800
Received: from xproxy.gmail.com ([66.249.82.200])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1En8dp-0001bL-5W
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 15 Dec 2005 22:00:30 -0800
Received: by xproxy.gmail.com with SMTP id s6so428609wxc
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 15 Dec 2005 22:00:28 -0800 (PST)
In-Reply-To: <200512160155.17019.lucasvr@gobolinux.org>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Lucas Correia Villa Real <lucasvr@gobolinux.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

Lucas Correia Villa Real wrote:
> On Thursday 15 December 2005 21:15, Antonino A. Daplas wrote:
>> Lucas Correia Villa Real wrote:
>>> Hi!
>>>
>>> While looking at i810fb_blank() on 2.4 and 2.6, I've seen that
>>> there's a difference on how pwr mask is handled: 2.4 unsets
>>> the pwr bit on FB_BLANK_VSYNC_SUSPEND and
>>> FB_BLANK_HSYNC_SUSPEND commands, while 2.6 turns that bit on.
>>> Was that modification expected, or was it a typo? The attached
>>> patch shows the code in question.
>> That's the expected change.  We only want to completely power
>> down the adapter on the deepest powersaving mode.
>>
>> Are you experiencing any problems with the new/old code?
> 
> A fellow worker has been working with software suspend 2 on a set 
> top box which has an i810 card. The suspend command was not making 
> the card to power off, so I looked at the code to give him a help, 
> when I saw that different behaviour from 2.4 (2.4 hasn't been 
> tested there, though).
> 
> I haven't seen this guy since then, so I don't know if that change 
> did the trick for him. I'll let you know as soon as possible.

I have neglected the suspend and resume hooks of i810fb so it's not
updated with the current code.  I don't have the hardware so I cannot
test.  Can you tell your friend to also try this patch if he cannot
solve the problem?

Tony

diff --git a/drivers/video/i810/i810_main.c b/drivers/video/i810/i810_main.c
index 4954a8e..563abc9 100644
--- a/drivers/video/i810/i810_main.c
+++ b/drivers/video/i810/i810_main.c
@@ -1558,35 +1558,28 @@ static int i810fb_suspend(struct pci_dev
 {
 	struct fb_info *info = pci_get_drvdata(dev);
 	struct i810fb_par *par = info->par;
-	int blank = 0, prev_state = par->cur_state;
-
-	if (state.event == prev_state)
-		return 0;
 
 	par->cur_state = state.event;
 
-	switch (state.event) {
-	case 1:
-		blank = VESA_VSYNC_SUSPEND;
-		break;
-	case 2:
-		blank = VESA_HSYNC_SUSPEND;
-		break;
-	case 3:
-		blank = VESA_POWERDOWN;
-		break;
-	default:
-		return -EINVAL;
-	}
-	info->fbops->fb_blank(blank, info);
-
-	if (!prev_state) { 
-		agp_unbind_memory(par->i810_gtt.i810_fb_memory);
-		agp_unbind_memory(par->i810_gtt.i810_cursor_memory);
-		pci_disable_device(dev);
+	if (state.event == PM_EVENT_FREEZE) {
+		dev->dev.power.power_state = state;
+		return 0;
 	}
+
+	acquire_console_sem();
+	fb_set_suspend(info, 1);
+
+	if (info->fbops->fb_sync)
+		info->fbops->fb_sync(info);
+
+	i810fb_blank(FB_BLANK_POWERDOWN, info);
+	agp_unbind_memory(par->i810_gtt.i810_fb_memory);
+	agp_unbind_memory(par->i810_gtt.i810_cursor_memory);
+	
 	pci_save_state(dev);
+	pci_disable_device(dev);
 	pci_set_power_state(dev, pci_choose_state(dev, state));
+	release_console_sem();
 
 	return 0;
 }
@@ -1595,22 +1588,28 @@ static int i810fb_resume(struct pci_dev 
 {
 	struct fb_info *info = pci_get_drvdata(dev);
 	struct i810fb_par *par = info->par;
+	int cur_state = par->cur_state;
 
-	if (par->cur_state == 0)
+	par->cur_state = PM_EVENT_ON;
+
+	if (cur_state == PM_EVENT_FREEZE) {
+		pci_set_power_state(dev, PCI_D0);
 		return 0;
+	}
 
-	pci_restore_state(dev);
+	acquire_console_sem();
 	pci_set_power_state(dev, PCI_D0);
+	pci_restore_state(dev);
 	pci_enable_device(dev);
+	pci_set_master(dev);
 	agp_bind_memory(par->i810_gtt.i810_fb_memory,
 			par->fb.offset);
 	agp_bind_memory(par->i810_gtt.i810_cursor_memory,
 			par->cursor_heap.offset);
-
+	i810fb_set_par(info);
+	fb_set_suspend (info, 0);
 	info->fbops->fb_blank(VESA_NO_BLANKING, info);
-
-	par->cur_state = 0;
-
+	release_console_sem();
 	return 0;
 }
 /***********************************************************************


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
