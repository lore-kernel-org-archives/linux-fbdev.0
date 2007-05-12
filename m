From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] pm3fb: various fixes
Date: Sun, 13 May 2007 04:31:28 +0800
Message-ID: <1179001889.4773.16.camel@daplas>
References: <464600501490d@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HmyFd-0004pc-Ab for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 12 May 2007 13:31:38 -0700
Received: from nz-out-0506.google.com ([64.233.162.229])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HmyFb-0004MD-Jt
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 12 May 2007 13:31:37 -0700
Received: by nz-out-0506.google.com with SMTP id i11so3255981nzi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 12 May 2007 13:31:35 -0700 (PDT)
In-Reply-To: <464600501490d@wp.pl>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

On Sat, 2007-05-12 at 19:58 +0200, Krzysztof Helt wrote:
> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> This patch:
> - fixes 16-bit RGBA 4444 and 5551 modes (use fbset -rgba to set 
> them)
> - kills wmb() after each register write by PM3_SLOW_WRITE_REG
> - kills inaccurate comments (leftovers from skeletonfb.c)
> - kills PCI class restriction, now it is more general and shorter
> - white spaces and other minor fixes and source reducing
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> ---
> 
> This patch contains also the fix send by Antonino today. Should I 
> redo the patch?

No need. That's a trivial merge.

Tony



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
