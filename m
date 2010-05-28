From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 28 May 2010 19:25:33 +0000
Subject: Re: Idea of a v4l -> fb interface driver
Message-Id: <Pine.LNX.4.64.1005282124060.27251@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.1005261559390.22516@axis700.grange>
 <AANLkTilnb20a4KO1NmK_y148HE_4b6ka14hUJY5o93QT@mail.gmail.com>
 <Pine.LNX.4.64.1005270809110.2293@axis700.grange>
 <AANLkTin_ia3Ym3z7FOu40voZkjCeMqSDZjuE_1aBjwOW@mail.gmail.com>
 <Pine.LNX.4.64.1005272216380.1703@axis700.grange>
 <AANLkTikTBFPxbl5p9kI65bHt2UJZ5j0DAxFwJ6rzD77L@mail.gmail.com>
 <4C001643.2070802@gmx.de>
In-Reply-To: <4C001643.2070802@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Alex Deucher <alexdeucher@gmail.com>, Jaya Kumar <jayakumar.lkml@gmail.com>, linux-fbdev@vger.kernel.org, Linux Media Mailing List <linux-media@vger.kernel.org>

On Fri, 28 May 2010, Florian Tobias Schandinat wrote:

> Well hiding complexity is actually the job of an API. I don't see any need for
> major changes in fbdev for complex display setups. In most cases as a
> userspace application you really don't want to be bothered how many different
> output devices you have and control each individually, you just want an area
> to draw and to know/control what area the user is expected to see and that's
> already provided in fbdev.
> If the user wants the same content on multiple outputs just configure the
> driver to do so.
> If he wants different (independent) content on each output, just provide
> multiple /dev/fbX devices. I admit that we could use a controlling interface
> here that decides which user (application) might draw at a time to the
> interface which they currently only do if they are the active VT.
> If you want 2 or more outputs to be merged as one just configure this in the
> driver.
> The only thing that is impossible to do in fbdev is controlling 2 or more
> independent display outputs that access the same buffer. But that's not an
> issue I think.
> The things above only could use a unification of how to set them up on module
> load time (as only limited runtime changes are permited given that we must
> always be able to support a mode that we once entered during runtime).
> 
> The thing that's really missing in fbdev is a way to allow hardware
> acceleration for userspace.

How about a "simple" use-case, that I asked about in another my mail: how 
do you inform fbdev users, if a (DVI) display has been disconnected and 
another one with a different resolution has been connected?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
