From: Matt Turner <mattst88@gmail.com>
Date: Mon, 21 Mar 2011 21:37:47 +0000
Subject: Re: Future desktop on dumb frame buffers?
Message-Id: <AANLkTikAQ1ZLy6aoCPSQdJ8F9-D172uypff+-4+_WXPz@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <AANLkTimJWpebAskcjA+qQUDWXjiH6aHta4fri9z6OxRN@mail.gmail.com>
	<20110321110040.6f1ea6d3@jbarnes-desktop>
	<AANLkTimjOs8ZuKRUt1aOizhbRw2-Ni4bTPty-dKpZ-rz@mail.gmail.com>
	<20110321122518.6b7ec7e4@jbarnes-desktop>
	<20110321212008.384711f0@lxorguk.ukuu.org.uk>
In-Reply-To: <20110321212008.384711f0@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, dri-devel@lists.freedesktop.org, wayland-devel@lists.freedesktop.org, Geert Uytterhoeven <geert@linux-m68k.org>, timofonic timofonic <timofonic@gmail.com>

On Mon, Mar 21, 2011 at 9:20 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> =A0 1) inertia: fbdev has been around a lot longer, and provides most of
>> =A0 what embedded devices need anyway
>> =A0 2) feature set: why bother doing a full KMS driver if you're not
>> =A0 going to use any of the additional features it would provide (output
>> =A0 management, memory management, execution management)
>
> 3) its got documentation

My summer of code project's purpose was to create something of a
tutorial for writing a KMS driver. The code, split out into something
like 15 step-by-step patches, and accompanying documentation are
available from Google's website.

http://code.google.com/p/google-summer-of-code-2010-xorg/downloads/detail?n=
ame=3DMatt_Turner.tar.gz

My repository (doesn't include the documentation) is available here:
http://git.kernel.org/?p=3Dlinux/kernel/git/mattst88/glint.git;a=3Dsummary

There's a 'rebased' branch that contains API changes required for the
code to work with 2.6.37~.

It's nothing fantastic, but I've had a number of people tell me that
it was useful for them.

Thanks,
Matt
