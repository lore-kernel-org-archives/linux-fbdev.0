From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [PATCH] video: deferred io cleanup
Date: Wed, 24 Dec 2008 00:04:23 -0500
Message-ID: <45a44e480812232104i2e9ded44pb7ac603d98b80771@mail.gmail.com>
References: <20081217083713.30323.29055.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jayakumar.lkml@gmail.com>) id 1LFLv1-0007aP-99
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 24 Dec 2008 05:04:27 +0000
Received: from wf-out-1314.google.com ([209.85.200.172])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LFLuy-00058k-UI for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 24 Dec 2008 05:04:27 +0000
Received: by wf-out-1314.google.com with SMTP id 27so3013005wfd.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 23 Dec 2008 21:04:23 -0800 (PST)
In-Reply-To: <20081217083713.30323.29055.sendpatchset@rx1.opensource.se>
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

On Wed, Dec 17, 2008 at 3:37 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> From: Magnus Damm <damm@igel.co.jp>
>
> Make sure the mmap callback is set to NULL in the deferred io
> cleanup function. This way we can enable and disable deferred
> io on the fly.
>
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

Acked-by: Jaya Kumar <jayakumar.lkml@gmail.com>

------------------------------------------------------------------------------
