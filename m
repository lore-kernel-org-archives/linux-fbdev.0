From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 7/17] atyfb: Get initial mode timings from LCD BIOS
Date: Tue, 18 Oct 2005 19:14:10 -0700
Message-ID: <20051018191410.6dacce75.akpm@osdl.org>
References: <4354BDB0.2070103@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ES3Th-0004Vv-Hv
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 18 Oct 2005 19:14:53 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)
	id 1ES3Te-0006AQ-4H
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 18 Oct 2005 19:14:50 -0700
In-Reply-To: <4354BDB0.2070103@gmail.com>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

"Antonino A. Daplas" <adaplas@gmail.com> wrote:
>
>  "I've tried with video=atyfb:debug and video=atyfb:debug,mode:1280x600, \
>  nomtrr.
> 
>  In both case, the screen stays black, but seems divided into 4 vertical
>  bands. Some white lines pop up randomly on each vertical band."
> 
>  The problem is a combination of an incorrect xclk plus lack of timing
>  information.  The adapter is attached to an LCD device that can do
>  1280x600 (which is not a standard resolution).  The global mode database
>  does not have an entry for it.  Fortunately, the Video BIOS contains the
>  complete timing info for this display, however, atyfb is not making use
>  of it.
> 
>  Add support to get the timing information from the BIOS, if available.
> 
>  Signed-off-by: Antonino Daplas <adaplas@pol.net>
>  ---
>   atyfb_base.c |   58 ++++++++++++++++++++++++++++++++++++++++++++--------------
>   1 files changed, 44 insertions(+), 14 deletions(-)
> 
> 
>  diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
>  --- a/drivers/video/aty/atyfb_base.c
>  +++ b/drivers/video/aty/atyfb_base.c
>  @@ -2156,11 +2156,38 @@ static void __init aty_calc_mem_refresh(
>   
>   static struct fb_info *fb_list = NULL;
>   
>  +#if defined(__i386__) && defined(CONFIG_FB_ATY_GENERIC_LCD)
>  +static int __devinit atyfb_get_timings_from_lcd(struct atyfb_par *par,
>  +						struct fb_var_screeninfo *var)

Are we sure that __i386__ is the right thing to use here?  Is it not valid
for x86_64, for example?  Or other architecctures, come to that.

CONFIG_X86_32?


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
