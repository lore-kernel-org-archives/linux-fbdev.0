From: Jesse Barnes <jbarnes@virtuousgeek.org>
Date: Mon, 21 Mar 2011 19:59:05 +0000
Subject: Re: Future desktop on dumb frame buffers?
Message-Id: <20110321125905.0159a6f4@jbarnes-desktop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <AANLkTimJWpebAskcjA+qQUDWXjiH6aHta4fri9z6OxRN@mail.gmail.com>
	<20110321110040.6f1ea6d3@jbarnes-desktop>
	<AANLkTimjOs8ZuKRUt1aOizhbRw2-Ni4bTPty-dKpZ-rz@mail.gmail.com>
	<20110321122518.6b7ec7e4@jbarnes-desktop>
	<AANLkTi=kRdC1LoHxqwKxYKZJf99vBEU=OmQoY+zS1dK-@mail.gmail.com>
In-Reply-To: <AANLkTi=kRdC1LoHxqwKxYKZJf99vBEU=OmQoY+zS1dK-@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Corbin Simpson <mostawesomedude@gmail.com>
Cc: timofonic timofonic <timofonic@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, dri-devel@lists.freedesktop.org, wayland-devel@lists.freedesktop.org

On Mon, 21 Mar 2011 12:34:38 -0700
Corbin Simpson <mostawesomedude@gmail.com> wrote:
> Related: We are still missing basic userspace tools (kmsset, e.g.),
> some kind of direct KMS console (kmscon would work, if it existed),
> and an xf86-video-modesetting which compiles and works (this is
> actually possible now, with some patches that landed in 2.6.38 for
> generic KMS access.)

Yeah, we used to call that drmcon, and it's still a big open.  I think
there are some projects that sit on top of fbdev and provide a good
text console with fancy character and input support, but I don't know
if any of them have been ported to KMS to handle multiple outputs or
with an aim toward integrating into a distro as a VT replacement.

kmsset or something would be pretty easy to do; the modetest program in
the drm repo would be a good starting point for that.  One limitation
there is handling fbcon, which makes reallocation of the framebuffer
somewhat difficult.

IIRC plymouth or whatever Fedora is using these days uses the KMS APIs
though...

-- 
Jesse Barnes, Intel Open Source Technology Center
