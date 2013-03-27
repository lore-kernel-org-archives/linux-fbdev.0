From: Paul Bolle <pebolle@tiscali.nl>
Date: Wed, 27 Mar 2013 12:42:32 +0000
Subject: Re: [PATCH] powerpc: remove PReP
Message-Id: <1364388152.1345.29.camel@x61.thuisdomein>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1363864206.1390.117.camel@x61.thuisdomein>
 <20130322042159.GC26908@concordia>
 <1364381223.1345.18.camel@x61.thuisdomein>
 <CAMuHMdVs-Xxu9e=8WZbTBXE1_+iYOBKODgj9_EKmVbZA3z=8JA@mail.gmail.com>
In-Reply-To: <CAMuHMdVs-Xxu9e=8WZbTBXE1_+iYOBKODgj9_EKmVbZA3z=8JA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-fbdev@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Rob Landley <rob@landley.net>, Bjorn Helgaas <bhelgaas@google.com>, linuxppc-dev@lists.ozlabs.org, Adam Belay <abelay@mit.edu>

On Wed, 2013-03-27 at 13:05 +0100, Geert Uytterhoeven wrote:
> This section is CHRP-specific. The cs4232 driver also worked on the
> CHRP LongTrail.
> But I don't remember if the parameter values above also applied to LongTrail.
> I do remember it didn't work without specifing the right parameters, so you
> probably want to keep this section.

My reasoning was quite simply that this file was 14 years old so that
probably nobody is using that stuff anymore. Are people actually using
CHRP (whatever that is)? Anyhow, cs4232 is mentioned in some other files
too:
    $ git grep -l -n cs4232 Documentation/ 
    Documentation/powerpc/sound.txt
    Documentation/sound/alsa/ALSA-Configuration.txt
    Documentation/sound/alsa/alsa-parameters.txt
    Documentation/sound/oss/Introduction
    Documentation/sound/oss/Tropez+

Could these few lines be dumped in one of these (except
powerpc/sound.txt, of course)?


Paul Bolle

