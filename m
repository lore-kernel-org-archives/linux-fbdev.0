From: Matan Peled <chaosite@gmail.com>
Subject: Re: [announce 7/7] fbsplash - documentation
Date: Tue, 08 Mar 2005 07:00:05 +0200
Message-ID: <422D3155.9000102@gmail.com>
References: <20050308021706.GH26249@spock.one.pl> <200503080418.08804.arnd@arndb.de>
Reply-To: chaosite@gmail.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC9528BC61321363D8C2E62D3"
In-Reply-To: <200503080418.08804.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
To: Arnd Bergmann <arnd@arndb.de>
Cc: Michal Januszewski <spock@gentoo.org>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC9528BC61321363D8C2E62D3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Arnd Bergmann wrote:
> Nothing about the init command seems really necessary. Why not just do 
> that stuff from an /sbin/init script?

I'm not a kernel hacker by any definition, but I'm pretty sure its neccasery 
because we want it to be done before /sbin/init is ran, AKA hide the kernel 
messages :)

-- 
[Name      ]   ::  [Matan I. Peled    ]
[Location  ]   ::  [Israel            ]
[Public Key]   ::  [0xD6F42CA5        ]
[Keyserver ]   ::  [keyserver.kjsl.com]
encrypted/signed  plain text  preferred


--------------enigC9528BC61321363D8C2E62D3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFCLTFYA7Qvptb0LKURAvnBAKCJsNIa7q3QO//CA0RKGMklV74kjACfXiHM
xZ8Cjkb3XTt+dB/7jQbSCv8=
=07kU
-----END PGP SIGNATURE-----

--------------enigC9528BC61321363D8C2E62D3--
