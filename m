From: "eric miao" <eric.y.miao@gmail.com>
Subject: Re: [RFC 2.6.26-rc9 1/5] pxafb: add shared
	framebuffer interface
Date: Wed, 16 Jul 2008 15:00:31 +0800
Message-ID: <f17812d70807160000y4fb9e543gdd25d6b6937af81e@mail.gmail.com>
References: <1215955587-20367-1-git-send-email-jayakumar.lkml@gmail.com>
	<1215955587-20367-2-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KJ105-0000DS-L4 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 Jul 2008 00:00:33 -0700
Received: from rv-out-0708.google.com ([209.85.198.241])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KJ104-0002rt-GK
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 Jul 2008 00:00:33 -0700
Received: by rv-out-0708.google.com with SMTP id f25so4490937rvb.22
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 16 Jul 2008 00:00:32 -0700 (PDT)
In-Reply-To: <1215955587-20367-2-git-send-email-jayakumar.lkml@gmail.com>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: ymiao3@marvell.com, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

On Sun, Jul 13, 2008 at 9:26 PM, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
> These changes are to make it possible for a secondary driver to share the
> pxafb framebuffer. The changes include:
> - adding clkdev entry in pxafb_mach_info so that a driver can pass in the
>  correct struct device owner for the LCDCLK.

Is it possible that LCDCLK being requested by device other than
pxa_device_fb?? Could you give an example and we may work out
a better solution.

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
