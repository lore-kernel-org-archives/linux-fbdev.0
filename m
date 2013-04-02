From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Tue, 02 Apr 2013 11:50:14 +0000
Subject: Re: [PATCHv2 6/6] video: fb: vt8500: Convert framebuffer drivers to standardized binding
Message-Id: <20130402115014.GL20693@game.jcrosoft.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1364878200-26343-1-git-send-email-linux@prisktech.co.nz>
 <1364878200-26343-7-git-send-email-linux@prisktech.co.nz>
 <515AB229.4050204@ti.com>
 <CABjd4Yx7zBAR+o-X7u9K9+iUeMq5qc=8n70qx1EoKPBT1JMR4A@mail.gmail.com>
In-Reply-To: <CABjd4Yx7zBAR+o-X7u9K9+iUeMq5qc=8n70qx1EoKPBT1JMR4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 14:41 Tue 02 Apr     , Alexey Charkov wrote:
> 2013/4/2 Tomi Valkeinen <tomi.valkeinen@ti.com>:
> > On 2013-04-02 07:50, Tony Prisk wrote:
> >> Now that a display timing binding is available, convert our almost identical
> >> binding to use the standard binding.
> >>
> >> This patch converts the vt8500 and wm8505 framebuffer drivers and
> >> associated dts/dtsi files to use the standard binding as defined in
> >> bindings/video/display-timing.txt.
> >>
> >> There are two side-effects of making this conversion:
> >>
> >> 1) The fb node should now be in the board file, rather than the soc file as
> >> the display-timing node is a child of the fb node.
> >>
> >> 2) We still require a bits per pixel property to initialize the framebuffer
> >> for the different lcd panels. Rather than including this as part of the
> >> display timing, it is moved into the framebuffer node.
> >
> > This means that the boards using the current DT bindings won't work with
> > a kernel with these patches, right? Is that ok?
> 
> There are no known products shipping any DT-enabled firmware with
> these chips in the wild. The only way to run modern kernels on
> VIA/WonderMedia chips so far is by using the "appended DTB"
> workaround, and the instructions that have been posted to Wiki's and
> mailing list discussions imply that a fresh DTB is compiled from
> current kernel sources to produce a bootable image.
> 
> Thus, it seems that this change should not really break anything
> major, as the user base is quite small and those who use new code are
> most likely to use new DTB as well.
I usually disagree but ok

Best Regards,
J.
