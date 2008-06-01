From: Denis Oliver Kropp <dok@directfb.org>
Subject: Re: [directfb-dev] [directfb-users] DirectFB
	without FBDev
Date: Sun, 01 Jun 2008 09:10:01 +0200
Message-ID: <48424B49.8080202@directfb.org>
References: <483D7344.6030503@directfb.org>	<Pine.LNX.4.64.0805281901300.15083@anakin>	<483D9453.1080700@directfb.org>	<483D9C30.8010301@acdstar.com>	<483D9F4E.4000707@directfb.org>	<20080529165452.GA7708@powerlinux.fr>	<4840EB76.6040506@directfb.org>	<20080531062127.GA5425@powerlinux.fr>	<4840F060.7090500@directfb.org>	<20080531064501.GA7526@powerlinux.fr>
	<g1sd2n$q0v$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K2hhj-00011A-Ps for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 01 Jun 2008 00:10:11 -0700
Received: from directfb.org ([212.227.87.76] helo=www.directfb.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1K2hhi-0006Hv-Cn
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 01 Jun 2008 00:10:11 -0700
In-Reply-To: <g1sd2n$q0v$1@ger.gmane.org>
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
To: George Tsalikis <aliverius@tsalikis.net>
Cc: linux-fbdev-devel@lists.sourceforge.net, directfb-users@directfb.org, directfb-dev@directfb.org

George Tsalikis wrote:
> I am sorry to intrude in your discussion, since i am not an expert but i 
> would like to point:
> Shouldn't you consider now to become as cross-platform kernel-wise as 
> possible?

DRI is somewhat cross platform running on Linux and BSD.

DirectFB is cross platform as it's a user space library and can be ported
to any other OS with a bit of POSIX support. There's only a kernel module
(usually small) for certain drivers or in case you want to run multiple
processes in one session. But if the OS does not have separate processes,
it's not required anyhow, as each application is a thread there.

What do you mean by kernel-wise? Like DRI with shared kernel code between
Linux and BSD or like DirectFB with shared user space code portable over
different kernels?

-- 
Best regards,
   Denis Oliver Kropp

.------------------------------------------.
| DirectFB - Hardware accelerated graphics |
| http://www.directfb.org/                 |
"------------------------------------------"

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
