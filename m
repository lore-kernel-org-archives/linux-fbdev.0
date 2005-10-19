From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 7/17] atyfb: Get initial mode timings from LCD BIOS
Date: Wed, 19 Oct 2005 12:29:31 +0800
Message-ID: <4355CBAB.4030303@gmail.com>
References: <4354BDB0.2070103@gmail.com> <20051018191410.6dacce75.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ES5aP-0003Pa-Hh
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 18 Oct 2005 21:29:57 -0700
Received: from zproxy.gmail.com ([64.233.162.197])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1ES5aN-00043l-3e
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 18 Oct 2005 21:29:57 -0700
Received: by zproxy.gmail.com with SMTP id s18so1356nze
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 18 Oct 2005 21:29:53 -0700 (PDT)
In-Reply-To: <20051018191410.6dacce75.akpm@osdl.org>
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
To: Andrew Morton <akpm@osdl.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

Andrew Morton wrote:
> "Antonino A. Daplas" <adaplas@gmail.com> wrote:
>>  "I've tried with video=atyfb:debug and video=atyfb:debug,mode:1280x600, \
>>  nomtrr.
>>
>>  In both case, the screen stays black, but seems divided into 4 vertical
>>  bands. Some white lines pop up randomly on each vertical band."
>>
>>  The problem is a combination of an incorrect xclk plus lack of timing
>>  information.  The adapter is attached to an LCD device that can do
>>  1280x600 (which is not a standard resolution).  The global mode database
>>  does not have an entry for it.  Fortunately, the Video BIOS contains the
>>  complete timing info for this display, however, atyfb is not making use
>>  of it.
>>
>>  Add support to get the timing information from the BIOS, if available.
>>
>>  Signed-off-by: Antonino Daplas <adaplas@pol.net>
>>  ---
>>   atyfb_base.c |   58 ++++++++++++++++++++++++++++++++++++++++++++--------------
>>   1 files changed, 44 insertions(+), 14 deletions(-)
>>
>>
>>  diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
>>  --- a/drivers/video/aty/atyfb_base.c
>>  +++ b/drivers/video/aty/atyfb_base.c
>>  @@ -2156,11 +2156,38 @@ static void __init aty_calc_mem_refresh(
>>   
>>   static struct fb_info *fb_list = NULL;
>>   
>>  +#if defined(__i386__) && defined(CONFIG_FB_ATY_GENERIC_LCD)
>>  +static int __devinit atyfb_get_timings_from_lcd(struct atyfb_par *par,
>>  +						struct fb_var_screeninfo *var)
> 
> Are we sure that __i386__ is the right thing to use here?  Is it not valid
> for x86_64, for example?  Or other architecctures, come to that.
> 
> CONFIG_X86_32?
> 

This patch depends on aty_init_lcd() which is enclosed in this...

#ifdef __i386__
#ifdef CONFIG_FB_ATY_GENERIC_LCD
static void aty_init_lcd(struct atyfb_par *par, u32 bios_base)
...

...so I just follow that.


Tony


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
