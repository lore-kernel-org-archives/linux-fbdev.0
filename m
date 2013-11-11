From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 11 Nov 2013 13:34:02 +0000
Subject: Re: [PATCH 11/12] fbdev: shmobile-hdmi: Convert to clk_prepare/unprepare
Message-Id: <5280DCCA.7060106@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="doBwv2X0FHqhreMPgtNoaVkpBHOvc1fFc"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1383000569-8916-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383000569-8916-12-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20131031104809.GB18477@ns203013.ovh.net> <1388008.xjh7MrPrF3@avalon>
In-Reply-To: <1388008.xjh7MrPrF3@avalon>
To: linux-arm-kernel@lists.infradead.org

--doBwv2X0FHqhreMPgtNoaVkpBHOvc1fFc
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-11-09 16:13, Laurent Pinchart wrote:
> Hi Jean-Christophe,
>=20
> On Thursday 31 October 2013 11:48:09 Jean-Christophe PLAGNIOL-VILLARD w=
rote:
>> On 23:49 Mon 28 Oct     , Laurent Pinchart wrote:
>>> Turn clk_enable() and clk_disable() calls into clk_prepare_enable() a=
nd
>>> clk_disable_unprepare() to get ready for the migration to the common
>>> clock framework.
>>>
>>> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
>>> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
>>
>> Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
>=20
> Thank you. Could you please pick patches 11/12 and 12/12 up for v3.13 o=
r v3.14=20
> ?

Thanks, picked both for 3.13.

 Tomi



--doBwv2X0FHqhreMPgtNoaVkpBHOvc1fFc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSgNzKAAoJEPo9qoy8lh711XwQAIgNPHWL4HvT3/aT0SU8SdEu
LPeNFfeHEOHJ9tb9BbXfibczuIKcwCD82+5aXEXs3aXMCRnJbvaLXm5fQ63/wREK
ohNy2jjOGi4GctZA3DsKYJJNOaZ978aTGKIqd8lglJYqfjnnUN65PM4CmTdgvLgB
sVPWfso0M6JP6XBVDyoBBxCsmuQUOom7Rkw15zFJ0GS15EQWxPezkOv5o5dlQ9NV
pCHGQOL9lsOedL41Qj8UfR1C5V5neeKqODazN1P1ZO31LkAPorE/dL/ONzbT5lzE
ucOThne+MdqpY/N4P31KWtAJikC/ZHRLAZegHYtANehg+B4xvFq7kPUFIEIfWw9K
XqUAH+WlTABflzV6BqppCkZQ9jYhopfb+FOkqmbUtB4VU0ZFQUKc9cFql8ob+33U
D52g7RnWRrBjL79Q4WV2kvqaSyNC8dtIk5c/uZhSVti/SOTUfuiJonodD6Ug8NIk
ojCNYBZtvfGSaJ+9wpBc79753A2sE3KItqfjVtno7reYVh2pu2ywva1AKowEUbqS
9eXhRM45CCj/OMC9+NePiQ0bBJcl9PRodN+2h2oUSVhACf3wwcQYHVYhm1KniJiL
IUiNWyKb7arZzFIW4RO0dnd3noTddAZXX+F574njok8EsL2jLHX+7vnvZmwoC53F
Vu9HrudrRG+T/fJBiPS7
=qPzb
-----END PGP SIGNATURE-----

--doBwv2X0FHqhreMPgtNoaVkpBHOvc1fFc--
