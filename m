From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 15 Oct 2010 10:01:57 +0000
Subject: Re: [PATCH 0/4] fbdev: sh: "video=" command line parsing, improved HDMI
Message-Id: <20101015100156.GD7489@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.1010150942270.3945@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1010150942270.3945@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Fri, Oct 15, 2010 at 09:53:44AM +0200, Guennadi Liakhovetski wrote:
> Another round of SH-HDMI improvements. Tests showed, that the best result 
> is achieved with the 720p format on HDMI, to override that users are given 
> a possibility to use the "video=sh_mobile_lcdc:..." kernel command line to 
> specified a preferred video-mode.
> 
> Paul, since one of the patches touches the ap4evb board, it's better to 
> push this via genesis.
> 
Yes, there are quite a few HDMI patches queued up in the genesis tree
already, so I've added these to the bunch.
