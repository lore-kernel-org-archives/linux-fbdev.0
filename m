From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 02 Nov 2012 13:14:46 +0000
Subject: Re: [Qemu-devel] [PATCH] add bochs dispi interface framebuffer driver
Message-Id: <5093C746.50801@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1331201626-23402-1-git-send-email-kraxel@redhat.com>
	<20121019103515.GA30341@dhcp-192-168-178-175.profitbricks.localdomain>
	<5092797B.5090403@redhat.com>
	<20121102115346.GB20700@dhcp-192-168-178-175.profitbricks.localdomain>
In-Reply-To: <20121102115346.GB20700@dhcp-192-168-178-175.profitbricks.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vasilis Liaskovitis <vasilis.liaskovitis@profitbricks.com>
Cc: linux-fbdev@vger.kernel.org, qemu-devel@nongnu.org

>> Only with bochsfb or with vesafb (+ fbdev xorg driver) too?
> 
> vt-switching with vesafb/X11 works fine on a grml 64-bit image.  However, xorg
> uses vesa driver in this case, not fbdev (fbdev / fbdevhw xorg modules are
> initially loaded but then unloaded). X11 uses 1280x768 and vesafb uses 1024x768
> according to dmesg. 

You should be able to force the fbdev driver using xorg.conf.

> But i haven't been able to test ubuntu+vesafb.  Ubuntu kernels use efifb
> (CONFIG_FB_EFI=y) and fbconsoles don't work at all with this driver +
> qemu/seabios/vgastd.

I think this is a grub2 setup issue.  Grub2 can pass gfx mode params to
the linux kernel in a way efifb is able to handle.

> vt7 http://picpaste.de/bochsfb-badstart-AirrXZuF.png
> vt1 http://www.picpaste.de/bochsfb-badstart-f1-EO10MVdF.png

> it still happens with the latest bochsfb driver (tested with 3.6.0 though, not
> 3.7.0-rc3 yet)

Most likely this is a guest-side bug and not specific to bochsfb.
Console switching depends on all parties being cooperative.  Nothing
stops an application writing to the framebuffer even it isn't running on
the foreground console.

cheers,
  Gerd
