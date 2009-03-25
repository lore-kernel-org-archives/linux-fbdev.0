From: Jaya Kumar <jayakumar.lkml-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Metronomefb porting details
Date: Wed, 25 Mar 2009 05:03:20 -0400
Message-ID: <45a44e480903250203v39e040f6v3b16c27eb67fcc6a@mail.gmail.com>
References: <20090323131708.GA21177@jeknote.loshitsa1.net> <20090323140825.GB30847@jeknote.loshitsa1.net>
Reply-To: openinkpot-hackers-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <grbounce-qpToLQUAAABpAOdMKF8RyK0jmD8A53lq=gchlod-openinkpot-hackers=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20090323140825.GB30847-Hf4asEuLYtTApnrAjwkxG0OZDFfiGV3a@public.gmane.org>
Sender: openinkpot-hackers-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:openinkpot-hackers-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <mailto:openinkpot-hackers+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://googlegroups.com/group/openinkpot-hackers/subscribe>,
	<mailto:openinkpot-hackers+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Yauhen Kharuzhy <jekhor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: openinkpot-hackers-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, "linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>


On Mon, Mar 23, 2009 at 10:08 AM, Yauhen Kharuzhy <jekhor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Mon, Mar 23, 2009 at 03:17:08PM +0200, Yauhen Kharuzhy wrote:
>> Hi.
>>
>> I am porting metronomefb to new 5-inch bookreader (HanWong N516) and
>> have some questions.

Hi Yauhen,

btw, I had read that =BA=BA=CD=F5 N510 was taken on China's ShenZhou VIII
mission to space. http://hw99.com/news/newsview-664.htm  Assuming
Linux was on it, I think that was the first Linux device in space
orbit. Nice.

>>
>> 1. metronomefb_var.[xy]res and [xy]res_virtual are set to fw/fh
>> values, which are not equal to real size of panel. Then this values
>> sending to X server and it make impropely decision about framebuffer
>> parameters. In my hardware I was able to set xres of LCDC framebuffer to
>> 800 and set fw field of epd_frame_table entry to 800 for resolving
>> this, but it only masks the problem.

I agree there is a problem. One question, in the above case with frame
and image width/height both 800/600, what is the observed result?

The intention for having the separation between frame and image
parameters was to accommodate LCDC constraints. For example, on AM200,
we have the constraint that 16-bpp transfers must be used which then
hits the PXA255's LCDC requirement that in 16bpp mode PPL (page 37 of
pxa255 datasheet) must be a multiple of 32 and since 400/32 =3D 12.5 so
have to be 13*32 =3D 416 * 2 =3D 832 pixels. So we have to use 832 as the
frame width reported to the LCDC hardware and also the metronome
controller. But we then incorrectly report 832 to X because I had not
finished the image buffer code to use image parameters rather than
frame. I'll work on a patch that fixes this.

>>
>> 2. According with specifications, Metronome supports 4 bit per pixel,
>> but in the metronomefb only 3 bpp format is used (metronomefb_var.red =
=3D { 4, 3, 0 }).
>> Can you explain this moment? Is it real colordepth of panels?

The AM200 display plus metronome/8track controller only supported 3bpp
according to the data and waveforms that I had in 2006. Actually,
looking today, according to E-Ink's documentation for the metronome
kit, eg:
http://www.e-ink.com/kits/AM_EPD_Kit_050907.pdf

"Display supports 8-level grayscale images" and "Grayscale Capability:
3-bit (8 gray levels)". But maybe this info is now out of date? If
metronome supports 4bpp, and I guess you may have a working 4-bit
waveform, then adding a configurable option to select the color depth
makes sense.

>>
>> 3. X server is works, but when I try to load gradient image directly to
>> /dev/fb1 (file with blocks of bytes from 0x00 to 0x0f), only black
>> screen is shown. When I load 0xff bytes to it, screen fills by white
>> color. Can you comment this?

Sounds like a bug in metronomefb write path versus mmap path. What
happens when Xfbdev is run? One thing to note, I had posted a patch
that removed the old metronomefb write path in favor of using a
generic write path.
http://marc.info/?l=3Dlinux-fbdev-devel&m=3D123023458729029&w=3D2 .

>>
>> 4. I found that error messages in the load_waveform function caused oops
>> because info->dev is not initialised at this stage yet.

Ok, we should fix that asap. Could you post the patch for this? I will
ack it straight away.

>>
>> 5. I think that waveform filesize check is completely useless. I have
>> two waveforms files for N516 and they have different sizes. I don't know
>> which file is used in the original firmware, but I tried both and they
>> work.

The reason I had the size check was to make sure that the waveform
that is used is the right one for the display. If you have waveforms
that are different in size but achieve desired results for that
display panel, then yes, I agree the check isn't useful and we can
remove it. Could you post the patch for this?

>>
>> 6. load_waveform() cannot be called more than one times with one
>> firmware because it changes fields trc and mc in the wfm_hdr structure.
>> I think that this is bug.

Currently, load_waveform is only called once at init. So that is
probably why I wrote it that way. I agree it would be better to make
it independent so that it can be called repeatedly if there is a
temperature change. I would welcome a patch to do that.

>
> And last question: are you have utility for waveform file decoding? I
> am going to create one but probably it exists already.

I'm not sure I understood your question. The waveform file is decoded
by load_waveform into memory. I didn't implement anything further. I
think it would be preferable to perform the decode and temperature
monitoring in userspace and only push the temperature adjusted
waveform to the kernel when there's been a measurable change. Is that
what you are suggesting?

Thanks,
jaya
