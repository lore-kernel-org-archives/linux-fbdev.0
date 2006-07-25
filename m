From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/4] [PATCH] gxfb: Fixups for the AMD Geode GX
	framebuffer driver
Date: Wed, 26 Jul 2006 00:48:10 +0100
Message-ID: <1153871290.7559.21.camel@localhost>
References: <20060724165454.18822.30310.stgit@cosmic.amd.com>
	 <20060724165602.18822.56823.stgit@cosmic.amd.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030201AbWGYWqw@vger.kernel.org>
In-Reply-To: <20060724165602.18822.56823.stgit@cosmic.amd.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, blizzard@redhat.com, dwmw2@redhat.com

On Llu, 2006-07-24 at 10:56 -0600, Jordan Crouse wrote:

> +#ifdef CONFIG_FB_GEODE_GX_SET_FBSIZE
> +unsigned int gx_frame_buffer_size(void) {
> +	return CONFIG_FB_GEODE_GX_FBSIZE;
> +}
> +#else
>  unsigned int gx_frame_buffer_size(void)
>  {
>  	unsigned int val;
> @@ -35,6 +40,7 @@ unsigned int gx_frame_buffer_size(void)
>  	val = (unsigned int)(inw(0xAC1E)) & 0xFFl;
>  	return (val << 19);
>  }
> +#endif

GAK, please fix your firmware to follow your own docs 8). I mean while
VGA emulation is hard honouring the frame buffer size query is trivial
to stick in the GPL'd VSA firmware and belongs there.
