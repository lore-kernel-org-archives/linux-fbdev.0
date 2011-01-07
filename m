From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 07 Jan 2011 02:15:57 +0000
Subject: Re: [PATCH 1/3] fbdev: sh_mobile_hdmi: add command line option to use the preferred EDID mode
Message-Id: <20110107021557.GJ22477@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.1101061919490.1248@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1101061919490.1248@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, Jan 06, 2011 at 07:23:54PM +0100, Guennadi Liakhovetski wrote:
> Currently, if no command-line option is specified, the sh_mobile_hdmi
> will use the default 720p video mode. If a command line option of the
> form "video=sh_mobile_lcdc:<width>x<height>@<refresh>" is provided,
> the driver will look for that mode among those, available in the
> monitor EDID. This patch adds the ability to request the driver to
> use monitor's preferred mode by specifying 0 as width and hight in
> the above string. If that mode is not supported by the system, the
> driver will continue scanning through EDID modes, until it finds a
> suitable one.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Ok, I tried applying this against all of the fbdev topic branches in the
sh tree, the fbdev tree, and Linus's tree (where the fbdev tree was just
merged), and it doesn't apply to any of them, so I have no idea what tree
you are working with, or if there are some dependencies or something that
you haven't specified.
