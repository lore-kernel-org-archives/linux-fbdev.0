From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 14 Nov 2014 07:58:39 +0000
Subject: Re: [PATCH v6] simplefb: add clock handling code
Message-Id: <5465B62F.1000306@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415906546-2408-1-git-send-email-hdegoede@redhat.com>
 <CAMuHMdW-6Eb9DSE=JQm7xWMhJUpt1xxLqS=6KU+=ZDMsmtiBag@mail.gmail.com>
In-Reply-To: <CAMuHMdW-6Eb9DSE=JQm7xWMhJUpt1xxLqS=6KU+=ZDMsmtiBag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On 11/13/2014 08:39 PM, Geert Uytterhoeven wrote:
> On Thu, Nov 13, 2014 at 8:22 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> changes in v6:
>> -Wrap the clock code in #ifdef CONFIG_OF, as simplefb is used on non
>>  devicetree platforms too
> 
> With clocks?

No, the existing users are in arch/x86/kernel/sysfb*.c so no clock support.

And any new users which need clocks should use devicetree.

Regards,

Hans
