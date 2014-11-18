From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 18 Nov 2014 11:01:08 +0000
Subject: Re: [PATCH 3/4] simplefb: Change simplefb_init from module_init to fs_initcall
Message-Id: <546B26F4.50302@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415830124-28787-1-git-send-email-hdegoede@redhat.com>
 <1415830124-28787-3-git-send-email-hdegoede@redhat.com>
 <20141113085238.GE20972@lukather>
 <CAMuHMdXZ4V4GHvyDLOP8FYvPuGArc5G0aO6NCE9FKHT24YRGPg@mail.gmail.com>
 <20141118101911.GA15769@ulmo>
In-Reply-To: <20141118101911.GA15769@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On 11/18/2014 11:19 AM, Thierry Reding wrote:
> On Thu, Nov 13, 2014 at 09:58:41AM +0100, Geert Uytterhoeven wrote:
>> Hi Maxime,
>>
>> On Thu, Nov 13, 2014 at 9:52 AM, Maxime Ripard
>> <maxime.ripard@free-electrons.com> wrote:
>>>> -module_init(simplefb_init);
>>>> +/*
>>>> + * While this can be a module, if builtin it's most likely the console
>>>> + * So let's leave module_exit but move module_init to an earlier place
>>>> + */
>>>
>>> Not really related to this patch itself, but do we want to support
>>> simplefb as a module? It seems like it's going to be most of the time
>>> broken.
>>
>> If it depends on clocks, it won't work as a module, as CCF will have disabled
>> all unused clocks at that point.
> 
> If it does depend on anything beyond clocks it won't work at all. Clocks
> are special because they get set up very early at boot time. If it turns
> out that a simplefb ever needs a regulator to remain on, and that's even
> quite likely to happen eventually, it's going to fail miserably, because
> those regulators will typically be provided by a PMIC on an I2C bus. The
> regulator won't be registered until very late into the boot process and
> a regulator_get() call will almost certainly cause the simplefb driver
> to defer probing.

Right, this has been discussed already and the plan is to have simplefb
continue its probe function and return success from it if it encounters
any -eprobe_defer errors, while tracking which resources it misses.

And then have a late_initcall which will claim any resources which failed
with -eprobe beforehand.

> Now deferring probing is a real showstopper for simplefb, because not
> only does it make the framebuffer useless as early boot console, once
> probing is attempted again the clocks that it would have needed to
> acquire to keep going will already have been switched off, too.

That is not true, even with the current implementation, if all necessary
drivers are built in, then simplefb will come up later, but it will still
come up before the late_initcall which disables the clocks.

Once we do the split probing described above (which is something which
we plan to do when it becomes necessary), then simplefb will still come
up early.

Regards,

Hans
