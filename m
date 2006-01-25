From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] i810fb: make probe of DDC3 optional
Date: Wed, 25 Jan 2006 15:49:34 +0800
Message-ID: <43D72D8E.9020609@gmail.com>
References: <20060125071718.GA7757@roarinelk.homelinux.net> <43D7278E.2030808@gmail.com> <20060125073052.GA7859@roarinelk.homelinux.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F1fP3-00030t-J8
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 24 Jan 2006 23:49:17 -0800
Received: from xproxy.gmail.com ([66.249.82.198])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1F1fP3-0007wn-DD
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 24 Jan 2006 23:49:17 -0800
Received: by xproxy.gmail.com with SMTP id h29so28821wxd
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 24 Jan 2006 23:49:16 -0800 (PST)
In-Reply-To: <20060125073052.GA7859@roarinelk.homelinux.net>
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
To: Manuel Lauss <mano@roarinelk.homelinux.net>
Cc: linux-fbdev-devel@lists.sourceforge.net

Manuel Lauss wrote:
> On Wed, Jan 25, 2006 at 03:23:58PM +0800, Antonino A. Daplas wrote:
>> Manuel Lauss wrote:
>>> Some time before 2.6.15, a third DDC channel was added to i810fb.
>>> On systems where these ddc pins are not connected, the probe
>>> takes about 10 seconds.
>>>
>>> Introduce a config option to disable the probe on ddc channel 3.
>>> Reduces boot time on my i815 laptop by 10 seconds.
>> Thanks.  Would a boot option be preferable than config?  Default would
>> be to skip probing the 3rd bus.
> 
> of course.
>  
>> If you agree, I'll do the patch myself.
> 
> fine with me, thanks.

Can you test this patch?

Probing for the 3rd bus needs to be done explicitly:

video=i810fb:ddc3; or

modprobe i810fb i810fb.ddc3=1

Tony 

diff --git a/drivers/video/i810/i810-i2c.c b/drivers/video/i810/i810-i2c.c
index e22d56e..231fe90 100644
--- a/drivers/video/i810/i810-i2c.c
+++ b/drivers/video/i810/i810-i2c.c
@@ -191,11 +191,11 @@ int i810_probe_i2c_connector(struct fb_i
         u8 *edid = NULL;
         int i;
 
-	DPRINTK("i810-i2c: Probe DDC%i Bus\n", conn);
-	if (conn < 4) {
+	DPRINTK("i810-i2c: Probe DDC%i Bus\n", conn+1);
+	if (conn < par->ddc_num) {
 		for (i = 0; i < 3; i++) {
 			/* Do the real work */
-			edid = i810_do_probe_i2c_edid(&par->chan[conn-1]);
+			edid = i810_do_probe_i2c_edid(&par->chan[conn]);
 			if (edid) 
 				break;
 		}
diff --git a/drivers/video/i810/i810.h b/drivers/video/i810/i810.h
index 6c187d5..579195c 100644
--- a/drivers/video/i810/i810.h
+++ b/drivers/video/i810/i810.h
@@ -280,6 +280,7 @@ struct i810fb_par {
 	u32 blit_bpp;
 	u32 ovract;
 	u32 cur_state;
+	u32 ddc_num;
 	int mtrr_reg;
 	u16 bltcntl;
 	u8 interlace;
diff --git a/drivers/video/i810/i810_main.c b/drivers/video/i810/i810_main.c
index 266d0ab..d8467c0 100644
--- a/drivers/video/i810/i810_main.c
+++ b/drivers/video/i810/i810_main.c
@@ -149,6 +149,7 @@ static int vyres      __devinitdata;
 static int sync       __devinitdata;
 static int extvga     __devinitdata;
 static int dcolor     __devinitdata;
+static int ddc3       __devinitdata = 2;
 
 /*------------------------------------------------------------*/
 
@@ -1763,6 +1764,8 @@ static void __devinit i810_init_defaults
 	if (sync) 
 		par->dev_flags |= ALWAYS_SYNC;
 
+	par->ddc_num = ddc3;
+
 	if (bpp < 8)
 		bpp = 8;
 	
@@ -1885,7 +1888,7 @@ static void __devinit i810fb_find_init_m
 	int found = 0;
 #ifdef CONFIG_FB_I810_I2C
 	int i;
-	int err;
+	int err = 1;
 	struct i810fb_par *par = info->par;
 #endif
 
@@ -1895,8 +1898,8 @@ static void __devinit i810fb_find_init_m
 #ifdef CONFIG_FB_I810_I2C
 	i810_create_i2c_busses(par);
 
-	for (i = 0; i < 4; i++) {
-		err = i810_probe_i2c_connector(info, &par->edid, i+1);
+	for (i = 0; i < par->ddc_num + 1; i++) {
+		err = i810_probe_i2c_connector(info, &par->edid, i);
 		if (!err)
 			break;
 	}
@@ -1983,6 +1986,8 @@ static int __devinit i810fb_setup(char *
 			vsync2 = simple_strtoul(this_opt+7, NULL, 0);
 		else if (!strncmp(this_opt, "dcolor", 6))
 			dcolor = 1;
+		else if (!strncmp(this_opt, "ddc3", 4))
+			ddc3 = 3;
 		else
 			mode_option = this_opt;
 	}
@@ -2190,6 +2195,8 @@ MODULE_PARM_DESC(sync, "wait for accel e
 module_param(dcolor, bool, 0);
 MODULE_PARM_DESC(dcolor, "use DirectColor visuals"
 		 " (default = 0 = TrueColor)");
+module_param(ddc3, bool, 0);
+MODULE_PARM_DESC(ddc3, "Probe DDC bus 3 (default = 0 = no)");
 module_param(mode_option, charp, 0);
 MODULE_PARM_DESC(mode_option, "Specify initial video mode");
 


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
