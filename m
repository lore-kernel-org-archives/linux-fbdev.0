From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 28 Feb 2010 14:47:32 +0000
Subject: Re: [PATCH 1/3] video: add support for getting video mode from device
Message-Id: <fa686aa41002280647q55e7940ej137ba3df052313c5@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <fa686aa41002161006l3b301febt94fe990df4bddfe9@mail.gmail.com>
	<1267307902-31939-2-git-send-email-agust@denx.de>
	<fa686aa41002272230s7f900c0fv1aabf0e26ccbf84c@mail.gmail.com>
	<4B8A2CD7.7070305@firmworks.com>
In-Reply-To: <4B8A2CD7.7070305-D5eQfiDGL7eakBO8gow8eQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Mitch Bradley <wmb-D5eQfiDGL7eakBO8gow8eQ@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wd-ynQEQJNshbs@public.gmane.org, dzu-ynQEQJNshbs@public.gmane.org, jrigby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org

On Sun, Feb 28, 2010 at 1:44 AM, Mitch Bradley <wmb@firmworks.com> wrote:
> Grant Likely Wrote:
>> On Sat, Feb 27, 2010 at 2:58 PM, Anatolij Gustschin <agust@denx.de> wrot=
e:
>> Also, since you're now in the realm of describing a video display,
>> which is separate from the display controller, you should consider
>> describing the display in a separate device tree node. =A0Maybe
>> something like this...
>>
>> video {
>> =A0 =A0 =A0 =A0compatible =3D "fsl,mpc5121-diu";
>> =A0 =A0 =A0 =A0display {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "<vendor>,<model>";
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0edid =3D [edid-data];
>> =A0 =A0 =A0 =A0};
>> };
>>
>
>
> As it turns out, I'm doing exactly that - exporting verbatim EDID data as
> the value of the "edid" property - for the display node on the Via version
> of the OLPC machine. =A0The kernel driver uses it instead of trying to ob=
tain
> the EDID data from the monitor, because the builtin OLPC display cannot
> supply EDID data through the usual hardware interfaces.

Cool.  That sounds sane then.  How do you go about generating the EDID
data?  Is there a tool that can do that?  Or did you hand craft it?

Cheers,
g.
