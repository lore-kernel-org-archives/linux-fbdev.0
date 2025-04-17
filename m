Received: from sonic313-20.consmr.mail.gq1.yahoo.com (sonic313-20.consmr.mail.gq1.yahoo.com [98.137.65.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486EC1FE444
	for <linux-fbdev@vger.kernel.org>; Thu, 17 Apr 2025 19:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.65.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744917222; cv=none; b=JSEvYnnOw4DSA3nxm8QPeP6lYtPFD2+l7r8uBsoYI5+Bclk0Vw7XnGrJ+QJDMHts6fIej56hsRrJHndgCVYLJEPnkX3jo7zPPsfmk7RtU5qI5Wn6r1OBGoZJZwMy1lruJX1L0LT8DQGLwdczkZdiCn1gGiTT116Ro2tqiCkOX0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744917222; c=relaxed/simple;
	bh=nZ2A3xhjqAAosSOM41l3fcubkQjRFiw/l46hUanQaFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AVhLx2GdkBLkZfDV7o/6AFC7EzeNqpXmtqNsoncuduBPHt9yGmfjhfktZtOARNQz9QqXhibajY+PFknJqKc+if6OXtCEOK6vRm6mrnLMKOoOpDdSF3g2M6yJNnDTbEifLRncvKpv5TbrhwfYfBoxyHGEuLKKVOZ4fqsqIOHF+Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com; spf=pass smtp.mailfrom=aol.com; dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b=WY36LsYv; arc=none smtp.client-ip=98.137.65.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aol.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="WY36LsYv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1744917220; bh=dQTkHFw+WBxoe+kShWgqjblniE2Ch2UOPNmjzkNX9iM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=WY36LsYvqgCUHaXMabVLDBBzjdwM5QvlbZB4E2N36JuyOajuELVYFvvmgPYHQmXEOSSiHJO6DKXHhakjfwYIeTVvnGivfHDMJmS2RASmXjgsgnjFlWBjjZPXV2rvz+sn1J3Ki1zhcLLDFvASiSbF4Fpn1D40x/fMYy5PPxh/JlK/brUPd4ULNTqonvmdlxM8qji+uLbhSB3UUY9unoB6zWqkv9kROZrNE2Nt74tGnWkeuB86DYp1INXm3pTW+8bkaCMnbw3SS0u8f2YbCHJ6XzLZ9EsbfJ0dw4Qrn8jOW3sutdL2H/OBTvgKWzZJKOb5owU/PAOfQBXttShpr0KVfQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1744917220; bh=H7fz2kq56Zhka/pft2Jg9aVaBd06Z2cj2jD86dRoYFd=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=jtz/PmAaskMT48J4Re2UBES0nHs0f4oPG92YY+z2AuWy3dlw67THm7i6ZMZtyo/m5VDy0ANKig6VnxVuLSf7KG9J2Rb+rvvVUetBHrOZvEbDjBbxfzxJHGCJ0kTNWpw9J6iX+QyvlRA3Hzqjhmlne1RAhmpiNIfGg6uBWh6/j5mKD77CqztHn+jdnOiNcqDm5GnkMTTHACZ9hzkEtMA4Yqk7tONWcJGMFK+SM7uTazaEZbhl+qvrKqgnju+27GPM32ROwAkFyuAqDxzXDWQW2Ej1qz3c08EA5YElxucnE/wMyXht0XzGSnBekuUuS9WOFO/r+qvBWm09cAUeQp2oyA==
X-YMail-OSG: .nEgz4UVM1nMwFoSNME3ln9MK2iyat_qRGodUAyOuOiGcwLfK9jMtoIu4oivoop
 eQjgg0D611f6Osi_5OA_Y1yUCk9cMu2MeSEuBaR726XD4v0sX9UZKa9ZNTVkNXAO.QtzEnwgw7_d
 3r6kMDZDHpK8mPQOUoesJJt2cb2RnkLK5_DM94xM2vDaWzWRZI2bUrY4wtWM3AtuG0tMx6rTg2pC
 QwiU0y6yfbRHHVz_sJ9op_3EFXG1ODlF8DpbIxkFxjPl3u3kSSIJdM5HB2ZE65hGt6quQNorAvxL
 lCRCK.6l7VoBNT6MScxxiys5PzNGKv_ASENVHjztGsE_g.kpJvoJIgz3AgVGGP4uiySYWgAS1ZkK
 qIpG_tl9W_R8BfacfI.QbeDQVhqjpJG_lBO9vWlAEX2H9CetnY7UU76Ip14CGbCSfvoGp_7T1anc
 8oY5wq3MUSFWxmim42sTgx2L2IE086lyv_2eCPtnJLMRiD.618fc8yEBdWVfwNFFottzI_0z2O3B
 1egTcyPod5c_oEdt5xmcvcnXmZ9LLzQQ9x7k16Joxu.lvzVvpqxQjeQZn2K.rLH9LZUWMztH9NwC
 J315Tlyya2sb4Ji6C5qRG.C1X9d3npSZfFMahy.NZkQuaYRWALvjtYBgREQ1KLXk9_FC7Rvyjid8
 NPTzVC92rbMTchJdm.pPELJ0aHxsXbl63jFpGNxFB6F9FZ5hC5keWPjQn.BZ_LTj0fAclAdqL6HQ
 19.bJBXmySqq20UF2sStpM0.IyP_pq_OzNVhwTp42sYljSxG5wr0Vk5XxIOAy.TOyWS9sIY3DQgs
 2kTKJifTzT1vNpzo5lpvYKU3ptWUXk7yuVWaHNuY0NayaGcJcZKmx2emOaAXwkgIs91FXkEURAad
 QJx7Ci46X1ESzNWwedv7D_4wB_smZpA9uEsz8x0IEmV83edSlIwdhKiZOH2z5KCINV46D.rukCpD
 nsmp5GadVf8qFD0Kogq_ccXCVMkd7cA4bPYANmbDjG1LjvxLngVaQ5Mg_bEMdhveHqqmzX8P4Dgj
 .GG9_NzLp0bP9d2lJZdIQ8ENNyBGNIlYbQq29Ut0MLREMrYEuUhzEqZhWm3Gromd.5Gx.HlRkQ8b
 8lj7NWBdXexA7PFI72yeObxOJiuplO.RFqsVQDHvZbwTAn.Fe4411S2T2w2H_MR9PXmYrzn_vUmE
 RVy9BsD0YSVMlc2SXPy5Q05TOGogH74UYGi6SriDD5yW6AA__fIoeZ.Lu.QIaEdNawkz17X8AaCF
 peNerG4wuUB9jvWpn7WF.2.lfX05g6Jnrpc.qBw12DSjI8xEKuGHeMVMBsVDNDSF88trTnSo7Awt
 J1jQOrYVvEb8AKmKYOjH_9d8bUQzJs31r9eKzJ_lDxYAu4jRlumEin2n0od3.jR15_jeLiHGJkaQ
 DSPnao0CXA83vNgr8LMe8YLb3TGrd4LdYUu7WOvSGazQfTFy.TeN76ZaYZPcCtHm1LK8qUxweG1c
 CaHFTOJJOvD9plGNsziLOnuC31D6sSb.T5psKNsJ_aSlZ.ptryojx719kMAzArvi.bWMWNdicHPk
 aaXBFqF7gEh.M5BCfzHqfZ48tlC5ndb3Jlrlq2fc4Xce6ihGGxNm_Zg1fhblbTKmmy6PYj3446jB
 tWYaDYAw4vamJOmv_pYkTOby3QNXcJZsxTM4UrqrSO0dOuey06c9nEvKzgwPhqDIVFv0xGkscmLh
 d55ywJ3nHzLgrL8uLSeuhEJtk43u3SM19zak2UYoL8x6SHsn6qaUowC3p9Tr6lIecjrS9e8hB.GE
 FAJW9jYqpJxUPl8CZuWxVYa7aYtLRVwh4lcXdP6YtgP.iQo2bQYs17kBViPQCqdO964yDzPxEpXP
 ypNNvTjGBTEIer7ARTSB8lzCc1fhNnmiEIHgeRlWv_3y9OyQh7OOkHrq2EsCoxH6UfuIx8dCbb7B
 cqVaEsDOE50.mFaiNm2kEIVXPU3zIbtzqpdqkYGx3kylj4DKIWH7Q7aBHBWuUeA3N0iObo6B5PMu
 VF4BD_ngGnqh6YOGV3mqQ8wevuQmIvDn8ePSJiF.11BAaK7HxWCtrlZkoMUIleyP952EsXblqtq8
 VRWkSX0lbbtv.mN1Iz6czPMcjMeImvQoUFTF8PYBzsSrhEUWQwSowEqO6oQmNNiULNCmBgc7JhMV
 fgU.CkolmE6Ri1lgFSroVDNb8ScmioIbkCbUWW8yrqUJCryABffrURgpZ4WzDYXaSrqvoD1ThtMP
 6Srg6QkHMlkTXOseDm4XN6r1Imd781MGD3Mhr5Dq3Ng7DLEDmI3WH7YjbxG_huAb9qelsF5p4nbM
 -
X-Sonic-MF: <rubenru09@aol.com>
X-Sonic-ID: df9aa4d9-7349-4be8-91d4-71c297b4ca3b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.gq1.yahoo.com with HTTP; Thu, 17 Apr 2025 19:13:40 +0000
Received: by hermes--production-ir2-858bd4ff7b-9r9sx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6040ee699aaf3d3f072b53831b62751d;
          Thu, 17 Apr 2025 19:03:29 +0000 (UTC)
From: Ruben Wauters <rubenru09@aol.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Cc: Ruben Wauters <rubenru09@aol.com>,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] staging: sm750fb: rename gDviCtrlChipName
Date: Thu, 17 Apr 2025 20:02:50 +0100
Message-ID: <20250417190302.13811-3-rubenru09@aol.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250417190302.13811-1-rubenru09@aol.com>
References: <20250417190302.13811-1-rubenru09@aol.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Renames gDviCtrlChipName to dvi_controller_chip_name
This fixes checkpatch.pl's camel case check.

Signed-off-by: Ruben Wauters <rubenru09@aol.com>

---

I changed the name to dvi_controller_chip_name as I
believe it is somewhat more descriptive than
g_dvi_ctrl_chip_name. If the second one is wanted instead
please let me know and I will change it
---
 drivers/staging/sm750fb/ddk750_sii164.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index dd7811b18bf6..d4309e0d807f 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -14,7 +14,7 @@
 
 #ifdef SII164_FULL_FUNCTIONS
 /* Name of the DVI Controller chip */
-static char *gDviCtrlChipName = "Silicon Image SiI 164";
+static char *dvi_controller_chip_name = "Silicon Image SiI 164";
 #endif
 
 /*
@@ -254,7 +254,7 @@ void sii164_reset_chip(void)
  */
 char *sii164_get_chip_string(void)
 {
-	return gDviCtrlChipName;
+	return dvi_controller_chip_name;
 }
 
 /*
-- 
2.45.2

