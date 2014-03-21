From: Tormod Volden <lists.tormod@gmail.com>
Date: Fri, 21 Mar 2014 20:27:27 +0000
Subject: Re: How to make framebuffer look like a real monitor?
Message-Id: <CAArsGaaqeLxyHG287UAgVQHDBMq2bRuoMP8X4nmidnTffTX-ig@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CADAXeK1HznKm6AuWa1431i0u+GSKkXq0u3FWMFvbHU95FJQbzg@mail.gmail.com>
In-Reply-To: <CADAXeK1HznKm6AuWa1431i0u+GSKkXq0u3FWMFvbHU95FJQbzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Fri, Mar 21, 2014 at 3:30 PM, Ivan Drobyshevskyi wrote:
> Is there a way to make X treat Linux framebuffer device (e.g. /dev/fb0
> backed by virtual framebuffer) as a real display? Ideally it should
> appear in system display settings as a configurable monitor. Does it
> require writing some kernel code or it's possible to somehow get away
> with for example X configuration?

If I understand your question correctly, you are asking for the xorg
fbdev driver:
http://www.x.org/releases/current/doc/man/man4/fbdev.4.xhtml

HTH,
Tormod
