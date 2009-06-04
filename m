From: Dave Airlie <airlied@gmail.com>
Subject: Re: [PATCH] fb: add support for handoff from
	firmware to hw framebuffers
Date: Thu, 4 Jun 2009 14:50:47 +1000
Message-ID: <21d7e9970906032150w7a159b7bgaa9fa3c0c17eadb6@mail.gmail.com>
References: <1244090788-31645-1-git-send-email-airlied@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <airlied@gmail.com>) id 1MC4ui-0006ML-TP
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 04 Jun 2009 04:50:52 +0000
Received: from yw-out-2324.google.com ([74.125.46.28])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MC4ue-0005dk-Un for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 04 Jun 2009 04:50:52 +0000
In-Reply-To: <1244090788-31645-1-git-send-email-airlied@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sf.net

On Thu, Jun 4, 2009 at 2:46 PM, Dave Airlie <airlied@gmail.com> wrote:
> From: Dave Airlie <airlied@redhat.com>
>
> With KMS we have ran into an issue where we really want the KMS fb driver
> to be the one running the console, so panics etc can be shown by switching
> out of X etc.

btw so far this is just an RFC.

Dave.

------------------------------------------------------------------------------
OpenSolaris 2009.06 is a cutting edge operating system for enterprises 
looking to deploy the next generation of Solaris that includes the latest 
innovations from Sun and the OpenSource community. Download a copy and 
enjoy capabilities such as Networking, Storage and Virtualization. 
Go to: http://p.sf.net/sfu/opensolaris-get
