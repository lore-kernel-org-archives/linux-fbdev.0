From: CUELLA Samuel <Samuel.CUELLA@supinfo.com>
Subject: RE : [PATCH 2.6.28 ] i810: kernel crash fix when  struct
 fb_var_screeninfo is supplied
Date: Thu, 5 Mar 2009 00:45:22 +0100
Message-ID: <02E43B9E8855E74E886358B5184B4CC9104620DA@mail2-aub1fr.esi-supinfo.com>
References: <02E43B9E8855E74E886358B5184B4CC9104620C0@mail2-aub1fr.esi-supinfo.com>
	<alpine.LNX.2.00.0903041108470.4971@jikos.suse.cz>
	<20090304142006.20ad72fe.akpm@linux-foundation.org>
	<alpine.LNX.2.00.0903042353350.4971@jikos.suse.cz>,<20090304151707.804b5e84.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757058AbZCDXw5@vger.kernel.org>
In-Reply-To: <20090304151707.804b5e84.akpm@linux-foundation.org>
Content-Language: fr-FR
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
To: Andrew Morton <akpm@linux-foundation.org>, Jiri Kosina <jkosina@suse.cz>
Cc: "adaplas@gmail.com" <adaplas@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "trivial@kernel.org" <trivial@kernel.org>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>

On  jeudi 5 mars 2009 00:17,  Andrew Morton[akpm@linux-foundation.org] wrote :

>On Wed, 4 Mar 2009 23:54:49 +0100 (CET)
>Jiri Kosina <jkosina@suse.cz> wrote:

>> On Wed, 4 Mar 2009, Andrew Morton wrote:
>>
>> > > This is not appropriate for trivial tree. CCing akpm and lkml.
>> > I don't have a copy of the original patch.
>>
>> This is what I got from Samuel (and rejected it for trivial tree, not
>> being trivial enough :) )
>>

>ok, thanks.

I was away, thanks for taking care of my patch :)

>> --- linux-2.6.28/drivers/video/i810/i810_main.c.orig    2009-02-26 15:23:03.000000000 +0100
>> +++ linux-2.6.28/drivers/video/i810/i810_main.c 2009-02-26 14:50:06.000000000 +0100
>> @@ -993,6 +993,8 @@ static int i810_check_params(struct fb_v
>>         struct i810fb_par *par = info->par;
>>         int line_length, vidmem, mode_valid = 0, retval = 0;
>>         u32 vyres = var->yres_virtual, vxres = var->xres_virtual;
>> +       u32 yres = info->var.yres;
>> +
>>         /*
>>          *  Memory limit
>>          */

>So we have a file-wide static called `yres' - seems a bit dangerous.

Yes, for sure, but there is the same kind of symbol for xres, so I leave it.
As this variable is used to hold the 'yres' module parameter value, I think  it's named upon this one.

>Rather than defining a local which shadows the global, it would be
>clearer to do it in this equivalent way, yes?

Yes, you're totaly right.


--- a/drivers/video/i810/i810_main.c~i810-fix-kernel-crash-fix-when-struct-fb_var_screeninfo-is-supplied
+++ a/drivers/video/i810/i810_main.c
@@ -993,6 +993,7 @@ static int i810_check_params(struct fb_v
        struct i810fb_par *par = info->par;
        int line_length, vidmem, mode_valid = 0, retval = 0;
        u32 vyres = var->yres_virtual, vxres = var->xres_virtual;
+
        /*
         *  Memory limit
         */
@@ -1002,12 +1003,12 @@ static int i810_check_params(struct fb_v
        if (vidmem > par->fb.size) {
                vyres = par->fb.size/line_length;
                if (vyres < var->yres) {
-                       vyres = yres;
+                       vyres = info->var.yres;
                        vxres = par->fb.size/vyres;
                        vxres /= var->bits_per_pixel >> 3;
                        line_length = get_line_length(par, vxres,
                                                      var->bits_per_pixel);
-                       vidmem = line_length * yres;
+                       vidmem = line_length * info->var.yres;
                        if (vxres < var->xres) {
                                printk("i810fb: required video memory, "
                                       "%d bytes, for %dx%d-%d (virtual) "
_

>This assumes that the original change was actually correct.  Should
>both sites whcih use the global `yres' have been converted to use
>info->var.yres, or just one of them?
Yes, the two sites have to be changed. The orginal 'yres' global var is intended to be used as a module paramter value holder ( i810_main.c:2174), so it's not intended to be used to do other things than
module initialization.

P.S: Sorry for my bad english.