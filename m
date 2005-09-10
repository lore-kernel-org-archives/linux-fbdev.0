From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: can't access video memory?
Date: Sat, 10 Sep 2005 13:46:55 +0800
Message-ID: <4322734F.5050407@gmail.com>
References: <4321A7D6.9070702@comcast.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EDyDc-0007Mo-CT
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 Sep 2005 22:48:04 -0700
Received: from zproxy.gmail.com ([64.233.162.200])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EDyDb-0002bH-1F
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 Sep 2005 22:48:04 -0700
Received: by zproxy.gmail.com with SMTP id i11so15609nzh
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 09 Sep 2005 22:47:56 -0700 (PDT)
In-Reply-To: <4321A7D6.9070702@comcast.net>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Zack Smith <fbui@comcast.net>

Zack Smith wrote:
> Hi all,
> 
> As an experiment I tried accessing a part of (shared) video memory
> on my system that is not being used for display data, and this caused the
> kernel to crash. I have 6 megs of space and the display is using only half,
> but accessing above the 3 meg mark causes the problem. Accessing
> the lower 3 megs works fine.
> 
> Does anyone know what might cause this?

Depends on the driver.  It's possible that the driver did not ioremap
the entire graphics aperture (ie ioremapped only the first 3 megs).  Or
the driver set info->fix.smem_len to only 3 MB instead of 6.

Some drivers are now differentiating between remapped size vs actual
physical size (radeonfb).  info->screen_size, if not zero, tells the
amount of the remapped size while info->fix.smem_len, the actual physical
size.

Tony


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
