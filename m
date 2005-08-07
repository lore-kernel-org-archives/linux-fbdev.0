From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Choosing the correct framebuffer configuration
Date: Sun, 07 Aug 2005 19:00:55 +0800
Message-ID: <42F5E9E7.6090809@gmail.com>
References: <9e473391050805184756f055ea@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E1itd-0007S8-L3
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 04:00:49 -0700
Received: from wproxy.gmail.com ([64.233.184.200])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E1itc-0008VB-In
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 04:00:49 -0700
Received: by wproxy.gmail.com with SMTP id i17so380526wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 07 Aug 2005 04:00:41 -0700 (PDT)
In-Reply-To: <9e473391050805184756f055ea@mail.gmail.com>
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
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Jon Smirl wrote:
> If I understand things correctly the framebuffer config is supposed to
> be controlled by the transp/red/blue/green fields of fb_var_screeninfo
> during check_var. These fields are then combined to compute the
> bits_per_pixel.
> 
> radeonfb is working from the other direction, it starts with bpp and
> then computes ARGB. This looks wrong to me.
> 

> 16bpp aIndex 88 = 8/8

Set argb.length = 8, rgb.offset = 0, t.offset = 8.
The transp.offset differentiates ARGB8 from A8_RGB8.

Tony 


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
