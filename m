From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video
	card BOOT?
Date: Fri, 15 Oct 2004 13:45:10 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1097844301.9863.11.camel@localhost.localdomain>
References: <416E6ADC.3007.294DF20D@localhost> <87d5zkqj8h.fsf@bytesex.org>
	 <Pine.GSO.4.61.0410151437050.10040@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S266511AbUJONvZ@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.61.0410151437050.10040@waterleaf.sonytel.be>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>, penguinppc-team@lists.penguinppc.org

On Gwe, 2004-10-15 at 13:38, Geert Uytterhoeven wrote:
> Why not? Of course you won't get any output before the graphics card has been
> re-initialized to a sane and usable state...

That will depend on the system. The AMD64 boxes I have all allow the
bios to post the video card on S3 resume. 

For a lot of other stuff we can run the bios directly on the resume path
without emulation (or for intel call the video restore bios
int). For the rest this could be a useful weapon.
