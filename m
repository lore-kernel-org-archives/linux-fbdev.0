From: Peter =?iso-8859-1?q?H=FCwe?= <PeterHuewe@gmx.de>
Date: Mon, 19 Mar 2012 23:02:39 +0000
Subject: Howto consolidate xgifb (staging) with sisfb
Message-Id: <201203200002.40429.PeterHuewe@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi,

I'm currently trying to improve the xgifb driver from staging a bit and my 
final goal is to probably merge this driver with the sis driver (as both card 
families seem to have a lot in common).

However I'm a little bit unsure how to proceed here.

e.g. the sis and the xgifb driver have some nearly duplicated functions in 
common, e.g.
static void XGIfb_bpp_to_var(struct xgifb_video_info *xgifb_info, 			     
struct fb_var_screeninfo *var)
http://git.kernel.org/?p=linux/kernel/git/gregkh/staging.git;a=blob;f=drivers/staging/xgifb/XGI_main_26.c;hb=HEAD#l769

and 
static void sisfb_bpp_to_var(struct sis_video_info *ivideo, struct 
fb_var_screeninfo *var)
http://git.kernel.org/?p=linux/kernel/git/gregkh/staging.git;a=blob;f=drivers/video/sis/sis_main.c;hb=HEAD#l1129


have the same semantics. (the only difference is the _video_info struct).

-> Is there a way the xgifb driver can call the function from sis?  (I know 
it's static and not EXPORT_SYMBOL'ed)
Or how would you prepare the consolidation here ? 
(e.g. make the functions identical? and when the merge get's done sometime 
simply remove the duplicate?)



And how would you proceed with functions that are nearly identical (but each 
function is missing some bits from the other card)
e.g. 
static int sisfb_get_fix(struct fb_fix_screeninfo *fix, int con, struct 
fb_info *info)
http://git.kernel.org/?p=linux/kernel/git/gregkh/staging.git;a=blob;f=drivers/video/sis/sis_main.c;hb=HEAD#l1839
and 
static int XGIfb_get_fix(struct fb_fix_screeninfo *fix, int con,  struct 
fb_info *info)
http://git.kernel.org/?p=linux/kernel/git/gregkh/staging.git;a=blob;f=drivers/staging/xgifb/XGI_main_26.c;hb=HEAD#l1365
could be easily merged, but in which direction? Add the new code to directly 
to sis or 'backport' sis stuff to xgifb? or both (i.e. make them identical 
like in the first case?)



Thanks,
Peter
