/**
 * Copyright (C) 2000 - 2011 Silverpeas
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * As a special exception to the terms and conditions of version 3.0 of
 * the GPL, you may redistribute this Program in connection with Free/Libre
 * Open Source Software ("FLOSS") applications as described in Silverpeas's
 * FLOSS exception.  You should have received a copy of the text describing
 * the FLOSS exception, and it is also available here:
 * "http://www.silverpeas.com/legal/licensing"
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

package com.stratelia.webactiv.yellowpages.dao;

import com.stratelia.webactiv.yellowpages.model.Company;
import com.stratelia.webactiv.yellowpages.model.GenericContact;
import com.stratelia.webactiv.yellowpages.model.GenericContactRelation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface CompanyDao extends JpaRepository<Company, Integer> {

    @Query("select comp FROM GenericContact gccontact, GenericContact gccompany, GenericContactRelation rel, Company comp " +
            "WHERE gccontact.contactId = :contactId " +
            "AND gccontact.contactType = " + GenericContact.TYPE_COMPANY + " " +
            "AND gccontact.genericcontactId = rel.genericContactId " +
            "AND rel.enabled = " + GenericContactRelation.ENABLE_TRUE + " " +
            "AND rel.genericCompanyId = gccompany.companyId " +
            "AND gccompany.companyId = comp.companyId")
    List<Company> findCompanyListByContactId(@Param("contactId") int contactId);

}