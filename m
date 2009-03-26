From: Jaya Kumar <jayakumar.lkml-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Metronomefb porting details
Date: Thu, 26 Mar 2009 17:05:01 +0800
Message-ID: <45a44e480903260205k69426205ib802a5262883dd71@mail.gmail.com>
References: <20090323131708.GA21177@jeknote.loshitsa1.net> <20090323140825.GB30847@jeknote.loshitsa1.net> <45a44e480903250203v39e040f6v3b16c27eb67fcc6a@mail.gmail.com> <20090325101049.GA3786@jeknote.loshitsa1.net>
Reply-To: openinkpot-hackers-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <grbounce-qpToLQUAAABpAOdMKF8RyK0jmD8A53lq=gchlod-openinkpot-hackers=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20090325101049.GA3786-Hf4asEuLYtTApnrAjwkxG0OZDFfiGV3a@public.gmane.org>
Sender: openinkpot-hackers-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:openinkpot-hackers-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <mailto:openinkpot-hackers+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://googlegroups.com/group/openinkpot-hackers/subscribe>,
	<mailto:openinkpot-hackers+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Type: text/plain; charset="us-ascii"
To: Yauhen Kharuzhy <jekhor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: openinkpot-hackers-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, "linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>


On Wed, Mar 25, 2009 at 6:10 PM, Yauhen Kharuzhy <jekhor-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> OK. According to Metronome specifications, bits 4-7 in the pixel octet
> is 'current image' pixel value and bits 0-3 --- 'next image' value. Why
> metronomefb don't use this? As I understood, 'current image' values have
> no meaning in mode 3 waveforms, doesn't it?

In metronomefb, I used bits 5-7 in each octet because that's the mode
in which the waveform I had worked.

That is a good point about current image versus next image. I was not
able to get that working with metronome and the waveform that I had.
If it is working for you, then absolutely, yes, it makes sense to push
the current image data from the image buffer into the previous image
part of the octet when we perform the page update to push the new
image bits.

Thanks,
jaya
