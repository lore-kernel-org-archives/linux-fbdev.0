From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [PATCH] video: fix deferred io fsync()
Date: Wed, 24 Dec 2008 00:03:45 -0500
Message-ID: <45a44e480812232103o518079adx3774cc915cf77d7@mail.gmail.com>
References: <20081217083507.30318.63380.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jayakumar.lkml@gmail.com>) id 1LFLuR-0000XH-82
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 24 Dec 2008 05:03:51 +0000
Received: from wf-out-1314.google.com ([209.85.200.168])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LFLuN-0004rm-Nv for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 24 Dec 2008 05:03:51 +0000
Received: by wf-out-1314.google.com with SMTP id 27so3012786wfd.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 23 Dec 2008 21:03:45 -0800 (PST)
In-Reply-To: <20081217083507.30318.63380.sendpatchset@rx1.opensource.se>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Wed, Dec 17, 2008 at 3:35 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> From: Magnus Damm <damm@igel.co.jp>
>
> If CONFIG_FB_DEFERRED_IO is set, but there are framebuffers
> registered that does not make use of deferred io, then fsync()
> on those framebuffers will result in a crash. Fix that.
>
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

Acked-by: Jaya Kumar <jayakumar.lkml@gmail.com>

------------------------------------------------------------------------------
