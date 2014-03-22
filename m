From: Ivan Drobyshevskyi <drobyshevskyi@gmail.com>
Date: Sat, 22 Mar 2014 08:50:48 +0000
Subject: Re: How to make framebuffer look like a real monitor?
Message-Id: <CADAXeK33+gYvF-eRUV5UyZJSEZKUwa-63kk8urYd19tudxKDLg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CADAXeK1HznKm6AuWa1431i0u+GSKkXq0u3FWMFvbHU95FJQbzg@mail.gmail.com>
In-Reply-To: <CADAXeK1HznKm6AuWa1431i0u+GSKkXq0u3FWMFvbHU95FJQbzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Thank you, that could work. As I understand, using fbdev doesn't
support hotplug and the only way to setup it is via xorg.conf editing?

(in short, I need to create a virtual GPU that is treated as a real
one by desktop environment but instead of actual rendering only
writing to framebuffer in RAM is required).

On Fri, Mar 21, 2014 at 10:27 PM, Tormod Volden <lists.tormod@gmail.com> wrote:
> On Fri, Mar 21, 2014 at 3:30 PM, Ivan Drobyshevskyi wrote:
>> Is there a way to make X treat Linux framebuffer device (e.g. /dev/fb0
>> backed by virtual framebuffer) as a real display? Ideally it should
>> appear in system display settings as a configurable monitor. Does it
>> require writing some kernel code or it's possible to somehow get away
>> with for example X configuration?
>
> If I understand your question correctly, you are asking for the xorg
> fbdev driver:
> http://www.x.org/releases/current/doc/man/man4/fbdev.4.xhtml
>
> HTH,
> Tormod
