From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Opinions about YUV framebuffers
Date: Sun, 07 Aug 2005 17:52:27 +0800
Message-ID: <42F5D9DB.1040007@gmail.com>
References: <ba2a6a4405080700015bfebaed@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E1hpS-0002KT-GT
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 02:52:26 -0700
Received: from wproxy.gmail.com ([64.233.184.200])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E1hpQ-0002vf-8K
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 02:52:26 -0700
Received: by wproxy.gmail.com with SMTP id i5so612631wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 07 Aug 2005 02:52:15 -0700 (PDT)
In-Reply-To: <ba2a6a4405080700015bfebaed@mail.gmail.com>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

Nishant Kamat wrote:
> Hi experts,
> 
> I'd like to solicit some opinions about using the fbdev API for a
> display controller that accepts data in YUV format. fbcon seems to be
> written to work only for RGB framebuffers. Is that correct? Would it

No support for YUV formats but fbcon can be made to work with YUV formats.
For packed pixel, all you need to do is add another define in struct
fb_fix_screeninfo.visual (ie FB_VISUAL_YUV_PACKED, FB_VISUAL_YUV_PLANAR),
set info->pseudo_palette entries properly (in fb_setcolreg), do little
adjustments to cfb_* generic drawing functions so they recognize your new
visual formats and that's it.  

For planar formats, you need to write your own imageblit, copyarea and
fillrect.
  
> require lot of change to make it work with YUV data? Can X be run on
> YUV framebuffers?

I don't know if X supports YUV formats, and I also don't know how difficult
it will be to add support for it in X.   You can start with X's fbdev driver.

Tony


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
