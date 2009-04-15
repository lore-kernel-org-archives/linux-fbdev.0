From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] [V3] Xilinx : Framebuffer Driver: Add PLB support and 
	cleanup DCR
Date: Wed, 15 Apr 2009 10:03:22 -0600
Message-ID: <fa686aa40904150903r584a3fd6wb75d4f9f606873dc@mail.gmail.com>
References: <20090414200834.D05446F8056@mail163-wa4.bigfish.com> 
	<fa686aa40904150814p40813d25w9d04f7e88897a88@mail.gmail.com> 
	<20090415155837.139A119C0056@mail32-dub.bigfish.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <20090415155837.139A119C0056@mail32-dub.bigfish.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, Suneel Garapati <suneelg@xilinx.com>, linuxppc-dev@ozlabs.org, John Linn <linnj@xilinx.com>, akonovalov@ru.mvista.com

On Wed, Apr 15, 2009 at 9:58 AM, Stephen Neuendorffer
<stephen.neuendorffer@xilinx.com> wrote:
>> > - =A0 =A0 =A0 rc =3D of_address_to_resource(op->node, 0, &res);
>> > - =A0 =A0 =A0 if (rc) {
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&op->dev, "invalid address\n");
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return rc;
>> > + =A0 =A0 =A0 /*
>> > + =A0 =A0 =A0 =A0* To check whether the core is connected directly to =
DCR or PLB
>> > + =A0 =A0 =A0 =A0* interface and initialize the tft_access accordingly.
>> > + =A0 =A0 =A0 =A0*/
>> > + =A0 =A0 =A0 p =3D (u32 *)of_get_property(op->node, "xlnx,dcr-splb-sl=
ave-if", NULL);
>>
>> Hmmm. =A0This binding is undocumented. =A0It would be better to make the
>> decision on the presence/absence of the dcr-reg and/or reg properties.
>
> For backward compatibility with the 'old' way, the device tree generator =
for this core has both dcr-reg and reg properties (where the reg has been t=
ranslated back through the bridge).

So, what is in the regs and dcr-regs properties when DCR is used?

How about when MMIO is used?

g.


-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
