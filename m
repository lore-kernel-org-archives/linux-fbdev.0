From: Tormod Volden <lists.tormod@gmail.com>
Date: Sat, 22 Mar 2014 10:39:53 +0000
Subject: Re: How to make framebuffer look like a real monitor?
Message-Id: <CAArsGaZJd6kvZ6BjFRCnBUVYPkBALDhFQ_ax9N5bMJXV+P+2Dw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CADAXeK1HznKm6AuWa1431i0u+GSKkXq0u3FWMFvbHU95FJQbzg@mail.gmail.com>
In-Reply-To: <CADAXeK1HznKm6AuWa1431i0u+GSKkXq0u3FWMFvbHU95FJQbzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

>> On Fri, Mar 21, 2014 at 3:30 PM, Ivan Drobyshevskyi wrote:
>>> Is there a way to make X treat Linux framebuffer device (e.g. /dev/fb0
>>> backed by virtual framebuffer) as a real display? Ideally it should
>>> appear in system display settings as a configurable monitor. Does it
>>> require writing some kernel code or it's possible to somehow get away
>>> with for example X configuration?
>>
>> If I understand your question correctly, you are asking for the xorg
>> fbdev driver:
>> http://www.x.org/releases/current/doc/man/man4/fbdev.4.xhtml
>
> Thank you, that could work. As I understand, using fbdev doesn't
> support hotplug and the only way to setup it is via xorg.conf editing?
>
> (in short, I need to create a virtual GPU that is treated as a real
> one by desktop environment but instead of actual rendering only
> writing to framebuffer in RAM is required).

Does it have to be a linux-fbdev driver? There are virtual xorg
drivers (xf86-video-dummy?) or servers (Xfvb) that you can use like
this, all in user-space. Or you create a DRM driver (=E0 la the
experimental SimpleDRM driver from dri-devel@lists.freedesktop.org)
and use the xorg xf86-modesetting driver on top of it. However I don't
know if these examples support the kind of hotplug you want in their
current status.

Tormod
