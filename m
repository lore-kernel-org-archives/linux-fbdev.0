From: Jaya Kumar <jayakumar.lkml@gmail.com>
Date: Mon, 01 Feb 2010 22:33:35 +0000
Subject: Re: [PATCH/RFC 2.6.33-rc5 1/1] broadsheetfb: support storing waveform
Message-Id: <45a44e481002011433i11182989p658a836f38330e97@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1264395836-9892-1-git-send-email-jayakumar.lkml@gmail.com>
In-Reply-To: <1264395836-9892-1-git-send-email-jayakumar.lkml@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Tue, Feb 2, 2010 at 6:09 AM, Andrew Morton <akpm@linux-foundation.org> w=
rote:
> On Mon, =A01 Feb 2010 18:35:08 +0800
> Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
>
>> This patch adds the ability to store waveforms to broadsheetfb. It uses =
the
>> firmware class to retrieve the waveform. The request to store the wavefo=
rm
>> is triggered from a driver sysfs entry called loadstore_waveform. I
>> considered adding this to Documentation/ABI/testing/ but then decided ag=
ainst
>> it. It is not something I would expect a user to ever interact with. It
>> would be only useful for people doing platform bringup and other such di=
rty
>> activities. Also, I noticed it is not (yet?) common practice to document
>> sysfs entries for fbdev drivers in there. Please let me know your feedba=
ck.
>>
>> Thanks,
>> jaya
>>
>> This patch adds waveform storing capability to broadsheetfb. It uses the
>> firmware class to retrieve the waveform, and the request to initiate the
>> waveform storing is done via a driver sysfs entry, loadstore_waveform.
>
> Please educate me: broadsheet is a framebuffer device, is it not? =A0What
> does it mean to record a waveform into a framebuffer device? =A0In what
> way will a user observe the waveform? =A0Is it audio? =A0From the patch it
> appears that this mysterious device has flash memory too?
>
> Mystified!
>

Hi Andrew,

You are right, broadsheet is a framebuffer device. It is slightly
different than a typical framebuffer controller that drives a normal
TFT-LCD display. Most E-Ink display panels require a waveform in order
to function. That is, in order to drive the state of a pixel to black,
gray, or white, a specific waveform is utilized. Basically, that
waveform represents the specific E-field wiggling needed to get the
pixel to its optimal state given current temperature, and its previous
state. TN/IPS-LCDs use a similar concept but the driving waveform is
sufficiently simple that it is internalized in the TFT source/gate
driver.

These E-Ink waveforms are specific to a production batch. That is, a
batch of display films are produced, then they get characterized and a
waveform is generated for that batch. Broadsheet, typically, is
attached to its private SPI flash which is then flashed with this
waveform.

Users won't be able to see the waveform and typically won't ever need
to know about it. If however, the display panel attached to broadsheet
is changed out, then they will need to update their waveform. That
would typically be done at a factory or repair facility rather than by
a user.

Thanks,
jaya
