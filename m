From: "Antonino Daplas" <adaplas@gmail.com>
Subject: Re: [Linux-fbdev-devel] [PATCH] [git tree] Intel i9xx support for intelfb
Date: Thu, 23 Mar 2006 13:59:14 +0800
Message-ID: <b00ca3bd0603222159t63ea0f4j38e085ecff5b93c8@mail.gmail.com>
References: <21d7e9970603221820p5c89e46fgbd9878a3c60eac0a@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751127AbWCWF7Q@vger.kernel.org>
In-Reply-To: <21d7e9970603221820p5c89e46fgbd9878a3c60eac0a@mail.gmail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, sylvain.meyer@worldonline.fr, akpm@osdl.org

On 3/23/06, Dave Airlie <airlied@gmail.com> wrote:
> This patch adds support for i915G, i915GM and i945G to the intelfb
> driver in the kernel.
>
> It comes from work done by me on an X.org driver to support some
> non-VBE modesetting.
>
> This code isn't perfect but I've got no documentation so I cannot
> answer some questions on what exactly is going on just yet...

Better than nothing, and if it works for digital displays, then that
would be great.

>
> The code is also available in the i915fb branch or
> git://git.kernel.org/pub/scm/linux/kernel/git/airlied/intelfb-2.6
>
> It may need more testing on the i945G, and I think adding i945GM
> support might only be a few lines of code...
>
> Is there a framebuffer git tree this could go in?

There's no git tree for the framebuffer layer, I just send updates
directly to akpm. Andrew?

Tony
