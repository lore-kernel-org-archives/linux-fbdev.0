From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 18 Aug 2017 17:29:49 +0000
Subject: Re: [PATCH v3] fbcon: add fbcon=margin:<color> command line option
Message-Id: <5315503.hE13kgSm5B@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170801163629epcas2p49f5f4b204a3ce907b8a7f8239987022e@epcas2p4.samsung.com>
        <1501605357-30815-1-git-send-email-david@lechnology.com>
In-Reply-To: <1501605357-30815-1-git-send-email-david@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Lechner <david@lechnology.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday, August 01, 2017 11:35:57 AM David Lechner wrote:
> This adds a new command line option to select the fbcon margin color.
> 
> The motivation for this is screens where black does not blend into the
> physical surroundings of the screen. For example, using an LCD (not the
> backlit kind), white text on a black background is hard to read, so
> inverting the colors is preferred. However, when you do this, most of the
> screen is filled with white but the margins are still filled with black.
> This makes a big, black, backwards 'L' on the screen. By setting
> fbcon=margin:7, the margins will be filled with white and the LCD looks as
> expected.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

Patch queued for 4.14, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

