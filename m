From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 02 Oct 2014 14:23:15 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <542D5FD3.9090501@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <542C4404.8040501@wwwdotorg.org> <542CF3C3.2050708@redhat.com>
 <CAKON4Oy8sZ-d6JzWLi7pUeNFE5ge0fr5Tgoc_PSpKcOoiN-0yQ@mail.gmail.com>
 <542D476D.50004@redhat.com>
 <CAKON4OwOFVFZjxN-SJpDJLcyCpNOT4_mjjr9OpgGXmTYvZwT+A@mail.gmail.com>
 <542D4FB9.6090805@redhat.com>
 <CAKON4Oyb3KBWhGgKfwNop7+cwR=p=ZpVs-jfH0iQwm5scfOJ-A@mail.gmail.com>
 <542D5444.8090903@redhat.com>
 <CAKON4OxTmNRxSJum17RZGLLku5dAFPauzqyP0BOF-VC=bD=Hng@mail.gmail.com>
 <542D5C74.4050602@redhat.com> <20141002141849.GD4039@lukather>
In-Reply-To: <20141002141849.GD4039@lukather>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On 10/02/2014 04:18 PM, Maxime Ripard wrote:
> On Thu, Oct 02, 2014 at 04:08:52PM +0200, Hans de Goede wrote:
>>> 2) delay the clock/regulator cleanup until after there is a fixed
>>> window for device specific drivers to load in. Loading from initrd is
>>> a fixed window.
>>
>> As I already explained by example in another mail, this won't work:
>>
>> "delaying over the initrd is not helpful. Not having the real driver
>> load for whatever reasons, is not necessarily a boot blocking event,
>> and if it us just missing will not lead to any error messages.
>>
>> So the boot will continue normally with a black screen, and things are
>> still impossible to debug."
> 
> Plus:
> 
> 1) you might not have an initrd, which doesn't change a thing: your
> clock get disabled before you can load your driver
> 
> 2) you might not have a rootfs, and no driver to load, which would
> leave the clock enabled forever.
> 
>> We've been down the whole delay till $random point in time thing in the
>> past with storage enumeration, where you need to wait for say all members
>> of a raid set to show up. The lesson learned from that is that you should
>> not wait $random time / event, but wait for the actual storage device to
>> show up.
>>
>> And this is just like that, we need to wait for the actual display driver
>> to have loaded and taken over before "cleaning up" the clocks used by
>> the display engine.
>>
>> I guess we could just delay all clock cleanup until then, not really
>> pretty, and I still prefer to just list the clocks in the simplefb
>> dtnode, but if this version would be acceptable to all involved, I can
>> live with it.
>>
>> Mike, would a patch adding 2 calls like these to the clock core be
>> acceptable ?  :
>>
>> clk_block_disable_unused()
>> clk_unblock_disable_unused()
> 
> Thierry actually already made such a patch somewhere in this
> thread. The thing is that it should also block clk_disable (and all
> the potential users of clk_disable: clk_set_rate, clk_set_parent,
> etc.) from actually disabling them. Otherwise, you might still end up
> with your clock disabled.

A valid point, which brings us back to simply adding the clocks to the
dt node really being both the simplest solution, as well as the only
solution without any pitfalls.

Regards,

Hans
