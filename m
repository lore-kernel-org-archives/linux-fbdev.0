From: Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 30 Jan 2013 21:49:17 +0000
Subject: Re: [PATCH v5 0/8] video: mmp display subsystem
Message-Id: <20130130134917.c0aff826.akpm@linux-foundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1358410826-2557-1-git-send-email-zzhu3@marvell.com>
In-Reply-To: <1358410826-2557-1-git-send-email-zzhu3@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, 17 Jan 2013 16:20:26 +0800
Zhou Zhu <zzhu3@marvell.com> wrote:

> This series added support for display controller in
> Marvell "mmp" series processors.
> It also contains patches to enable display panel on
> TTC_DKB board.

I'll put these into -mm so they get a bit of linux-next exposure.

I'd really prefer not to merge them myself - it's been a few years
since I did fbdev things and I seem to have forgotten most of it :(. 
Hopefully Florian or some other fbdev person can comment on this
patchset.

I had a few minorish comments on code details.
