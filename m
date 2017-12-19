From: Max Staudt <mstaudt@suse.de>
Date: Tue, 19 Dec 2017 16:26:26 +0000
Subject: Re: [RFC PATCH v2 03/13] bootsplash: Flush framebuffer after drawing
Message-Id: <84bf675c-5415-00a3-d4b4-0ff2b14f0c2a@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171213194755.3409-1-mstaudt@suse.de>
 <20171213194755.3409-4-mstaudt@suse.de>
 <20171213213506.GD26573@phenom.ffwll.local>
 <d66a994a-cb3a-c1fb-8f91-adbd475a40f0@suse.de>
 <20171219122313.GE26573@phenom.ffwll.local>
 <8bbb0497-4a10-2f81-0040-6e7cd4e7353c@suse.de>
 <20171219135715.GG26573@phenom.ffwll.local>
 <8036b6a6-6ed5-2f34-e854-1c397a9f34d4@suse.de>
 <CAKMK7uHHJdN+5zyTnOrvSWJAjkms-cVUcF-mP=X3gEA1Jvedrw@mail.gmail.com>
In-Reply-To: <CAKMK7uHHJdN+5zyTnOrvSWJAjkms-cVUcF-mP=X3gEA1Jvedrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, michal@markovi.net, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, sndirsch@suse.com, Oliver Neukum <oneukum@suse.com>, Takashi Iwai <tiwai@suse.com>, dri-devel <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, philm@manjaro.org, =?UTF-8?Q?Bero_Rosenkr=c3=a4nzer?= <bernhard.rosenkranzer@linaro.org>

On 12/19/2017 05:09 PM, Daniel Vetter wrote:
> btw the reason drmcon didn't move is that David Herrmann moved on from
> hacking on graphics stuff, and no one needs it. There's nothing
> fundamentally wrong with his patches for a basic emergency console on
> plain drm, or the simpledrm driver to get a basic drm framebuffer up
> on vesafb/efifb and friends. Just wanted to bring this in since you
> sound like you're expecting this to magically have happened somehow.
> We don't merge code without real use-cases.

Don't worry, I'm not expecting this to have magically happened. It will happen when it will happen, or maybe never.

I'm just working with that I've got right now, and once a successor to fbcon takes it's throne, I'm very happy to help move the bootsplash over.



Max
