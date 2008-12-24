From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [Linux-fbdev-devel] [PATCH 02/05] video: deferred io cleanup
Date: Wed, 24 Dec 2008 00:05:52 -0500
Message-ID: <45a44e480812232105y160f49e6g4e7953956fd9a707@mail.gmail.com>
References: <20081219063359.2703.85817.sendpatchset@rx1.opensource.se>
	 <20081219063423.2703.88796.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20081219063423.2703.88796.sendpatchset@rx1.opensource.se>
Content-Disposition: inline
Sender: linux-sh-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, lethal@linux-sh.org, adaplas@gmail.com, linux-sh@vger.kernel.org

On Fri, Dec 19, 2008 at 1:34 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> From: Magnus Damm <damm@igel.co.jp>
>
> Make sure the mmap callback is set to NULL in the deferred io
> cleanup function. This way we can enable and disable deferred
> io on the fly.
>
> Signed-off-by: Magnus Damm <damm@igel.co.jp>


Acked-by: Jaya Kumar <jayakumar.lkml@gmail.com>
