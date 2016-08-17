From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Wed, 17 Aug 2016 19:27:00 +0000
Subject: Re: [drm-intel-nightly] 2016y-07m-14d-21h-13m-02s UTC: locking dependency: drm_modeset_lock_all() ||
Message-Id: <CA+icZUWn+zFjCHT+O6ihb7+kQDmn9N3Y588F45_=U=KYHZsoAw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CA+icZUUUUCybFnneuhVVT4Z_vymMcLp4HdCe3CDY5SerFnP+tg@mail.gmail.com>
 <20160715084045.GD1841@nuc-i3427.alporthouse.com>
In-Reply-To: <20160715084045.GD1841@nuc-i3427.alporthouse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Chris Wilson <chris@chris-wilson.co.uk>, Sedat Dilek <sedat.dilek@gmail.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, linux-fbdev@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Johannes Berg <johannes.berg@intel.com>, Thorsten Leemhuis <thl@ct.de>

On Fri, Jul 15, 2016 at 10:40 AM, Chris Wilson <chris@chris-wilson.co.uk> w=
rote:
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

[ CC Peter, Johannes and Thorsten "The regression reporter" ]

Peter has 2 fixes from Johannes in peterz/queue.git#locking/urgent
which fix the issue for me.

[1/2] Revert "drm/fb-helper: Reduce READ_ONCE(master) to lockless_dereferen=
ce"
[2/2] locking/barriers: suppress sparse warnings in lockless_dereference()

I tried today's Linus tree with those two fixes.

Chris backlight fix is no more needed here.

- Sedat -

[1] http://git.kernel.org/cgit/linux/kernel/git/peterz/queue.git/commit/?h=
=3Dlocking/urgent&id=F9d089b7830bbaa6ccaad29dff5fbb01d2a69945
[2] http://git.kernel.org/cgit/linux/kernel/git/peterz/queue.git/commit/?h=
=3Dlocking/urgent&id=1804f7121995e8ca341427d848c0c8d267147720
