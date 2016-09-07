From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 07 Sep 2016 11:29:50 +0000
Subject: Re: [PATCH] simplefb: Disable and release clocks and regulators in destroy callback
Message-Id: <dc027024-c2ad-85fa-8671-53781c95c584@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160907090919.27187-1-wens@csie.org>
 <CAMuHMdU3dgPzvHkd8qti1pwzf1aeUhyv7gdpufYkqxHPS4=VTw@mail.gmail.com>
In-Reply-To: <CAMuHMdU3dgPzvHkd8qti1pwzf1aeUhyv7gdpufYkqxHPS4=VTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On 07-09-16 13:12, Geert Uytterhoeven wrote:
> On Wed, Sep 7, 2016 at 11:09 AM, Chen-Yu Tsai <wens@csie.org> wrote:
>> simplefb gets unregister when a proper framebuffer driver comes in and
>> kicks it out. However the claimed clocks and regulators stay enabled
>> as they are only released in the platform device remove function, which
>> in theory would never get called.
>>
>> Move the clock/regulator cleanup into the framebuffer destroy callback,
>> which gets called as part of the framebuffer unregister process.
>
> Is this called before or after the new proper framebuffer driver kicks in?
> If before, it may cause glitches.

It is called by the new proper framebuffer driver's probe method,
so it can make sure that it has already claimed / enabled the
clocks/regulators before it calls remove_conlicting_framebuffers,
avoiding the glitch.

Regards,

Hans
