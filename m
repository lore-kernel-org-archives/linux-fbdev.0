From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Fri, 15 Jul 2016 10:37:57 +0000
Subject: Re: [drm-intel-nightly] 2016y-07m-14d-21h-13m-02s UTC: locking dependency: drm_modeset_lock_all() ||
Message-Id: <CA+icZUXg98HyjWG4HiyC2=CTw7iRMBja18JSLcsM3A9dZ_BP6A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CA+icZUUUUCybFnneuhVVT4Z_vymMcLp4HdCe3CDY5SerFnP+tg@mail.gmail.com>
 <20160715084045.GD1841@nuc-i3427.alporthouse.com>
In-Reply-To: <20160715084045.GD1841@nuc-i3427.alporthouse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chris Wilson <chris@chris-wilson.co.uk>, Sedat Dilek <sedat.dilek@gmail.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, linux-fbdev@vger.kernel.org

On Fri, Jul 15, 2016 at 10:40 AM, Chris Wilson <chris@chris-wilson.co.uk> wrote:
> On Fri, Jul 15, 2016 at 08:00:25AM +0200, Sedat Dilek wrote:
>> Hi,
>>
>> I see the below call-trace with latest d-i-n, guess latest linux-next
>> will cause same issues.
>> ( Beyond this, there exist also a build failure which me and Stephen
>> have reported. )
>> The call-trace is reproducible with my setup and seen on every boot.
>>
>> Not sure if this is a problem in intel-gfx or fbdev.
>
> Personally, I blamed backlight,
> https://patchwork.freedesktop.org/patch/95769/
>

Thanks, I try the patch when I am at home in front of my machine.

- sed@ -
