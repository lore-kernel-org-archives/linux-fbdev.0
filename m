From: Dave Airlie <airlied@gmail.com>
Date: Wed, 23 Nov 2011 11:48:27 +0000
Subject: Re: [RFC] Virtual CRTCs (proposal + experimental code)
Message-Id: <CAPM=9tyPOkS7w3593-3ZtjSN6E+cO82125Lpmn2er8r9=PzROQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CA+4h6Hk3gE+8ou6NSMhoGJWZJ-5aM1OgC0HFoKs55fjfQ-qN8g@mail.gmail.com>
In-Reply-To: <CA+4h6Hk3gE+8ou6NSMhoGJWZJ-5aM1OgC0HFoKs55fjfQ-qN8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ilija Hadzic <ilijahadzic@gmail.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

>
> I would like to bring to the attention of dri-devel and linux-fbdev
> community a set of hopefully useful and interesting patches that
> I (and a few other colleagues) have been working on during the past
> few months. Here, I will provide a short abstract, so that you can
> decide whether this is of interest for you. At the end, I will
> provide the pointers to the code and documentation.
>
> The code is based on Dave Arilie's tree, drm-next branch and it
> allows a GPU driver to have an arbitrary number of CRTCs
> (configurable by user) instead of only those CRTCs that represent
> real hardware.

So another question I have is how you would intend this to work from a
user POV, like how it would integrate with a desktop environment, X or
wayland, i.e. with little or no configuration.

I still foresee problems with tiling, we generally don't encourage
accel code to live in the kernel, and you'll really want a
tiled->untiled blit for this thing, also for Intel GPUs where you have
UMA, would you read from the UMA.

It also doesn't solve the optimus GPU problem in any useful fashion,
since it can't deal with all the use cases, so we still have to write
an alternate solution that can deal with them, so we just end up with
two answers.

Dave.
