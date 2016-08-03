From: Jani Nikula <jani.nikula@linux.intel.com>
Date: Wed, 03 Aug 2016 08:42:25 +0000
Subject: Re: [Intel-gfx] [drm-intel-nightly] 2016y-07m-14d-21h-13m-02s UTC: locking dependency: drm_modeset_l
Message-Id: <87twf2qm4u.fsf@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CA+icZUUUUCybFnneuhVVT4Z_vymMcLp4HdCe3CDY5SerFnP+tg@mail.gmail.com>
 <87oa5ctxzm.fsf@intel.com>
 <CA+icZUU2Q7e5rthM9+ydPM5EtROufY1wVmg-MvKwGbPq=o3a0A@mail.gmail.com>
In-Reply-To: <CA+icZUU2Q7e5rthM9+ydPM5EtROufY1wVmg-MvKwGbPq=o3a0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sedat.dilek@gmail.com
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, intel-gfx <intel-gfx@lists.freedesktop.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org

On Tue, 02 Aug 2016, Sedat Dilek <sedat.dilek@gmail.com> wrote:
> On Mon, Aug 1, 2016 at 3:33 PM, Jani Nikula <jani.nikula@linux.intel.com> wrote:
>> On Fri, 15 Jul 2016, Sedat Dilek <sedat.dilek@gmail.com> wrote:
>>> Hi,
>>>
>>> I see the below call-trace with latest d-i-n, guess latest linux-next
>>
>> FWIW, "d-i-n" is ambiguous (drm-intel-next vs. drm-intel-nightly) and we
>> don't use that ourselves.
>>
>
> Oh, sorry with d-i-n I meant drm-intel-nightly.
> Normally, I also point to the "integration manifest"
> like...drm-intel-nightly: 2016y-08m-02d-14h-10m-12s UTC integration
> manifest.
> You do not test d-i-n yourself?
> Strange.

We do not use the *acronym* "d-i-n" ourselves because it is
ambiguous. drm-intel-nightly is our main test target.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Technology Center
